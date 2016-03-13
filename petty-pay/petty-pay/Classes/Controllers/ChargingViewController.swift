//
//  ChargingViewController.swift
//  petty-pay
//
//  Created by Kotaro Kamiya on 3/13/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ChargingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //柴田のserverに繋ぐ用。使わなければcomment out
        NSOperationQueue().addOperationWithBlock({ () -> Void in
            self.fetchAPI()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchAPI() {
        let mufgApiLogic = MufgApiLogic()
        var _flag = false
        
        let logic:NSData -> Void = {result in
            let obj = mufgApiLogic.jsonToDict(result)!
            let flag = obj["name"] as! String
            if flag == "true"{
                _flag = true
                ClosureAlert.showAlert(self, title: "受領完了", message: "支払いが行われました",
                    completion: self.completeAction
                )
                print("status changed!")
            }else{
                print("polling ...")
            }
        }
        
        for _ in 0...100000 {
            if !_flag {
                sleep(1)
                mufgApiLogic.fetchStatus(logic)
            }
        }
    }

	// ------------------------------------------------
	// Define action when complete or cancel
	// ------------------------------------------------

	func showMainStoryboard() {
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let mainTabViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainTabViewControllerID")
		self.presentViewController(mainTabViewController, animated: true) { () -> Void in
        	    print("Show mainTabViewController")
		}
	}
	
	func completeOrCancelAction() {
		PeripheralManager.stopAdvertising()
		showMainStoryboard()
	}

	func completeAction(isPositive: Bool) {
		if isPositive {
			completeOrCancelAction()
		} else {
			// ngの処理
		}
	}

	// ------------------------------------------------
	// UI
	// ------------------------------------------------
	
	@IBAction func alerting(sender: UIButton) {
		ClosureAlert.showAlert(self, title: "受領完了", message: "支払いが行われました",
            completion: completeAction
        )
	}
	
	@IBAction func cancelCharge(sender: UIButton) {
		completeOrCancelAction()
    }
	
}

final class ClosureAlert {
	// Ref. http://sakebook.hatenablog.com/entry/2015/08/12/133756
    
    class func showAlert(parentViewController: UIViewController, title: String, message: String, completion: ((Bool) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yesAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (action:UIAlertAction!) -> Void in
            // 引数にメソッドが使われてれば実行する
            if let completion = completion {
                // yesなのでtrue
                completion(true)
            }
        })
        
        let noAction = UIAlertAction(title: "NG", style: UIAlertActionStyle.Default, handler: {
            (action:UIAlertAction!) -> Void in
            // 引数にメソッドが使われてれば実行する
            if let completion = completion {
                // noなのでfalse
                completion(false)
            }
        })
        
        alert.addAction(yesAction)
        // alert.addAction(noAction)
        parentViewController.presentViewController(alert, animated: true, completion: nil)
    }
}