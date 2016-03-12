//
//  PaymentViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class PaymentViewController: UIViewController {

	// Create Motion Manager and Handler
	let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
		startMotionSensing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func startMotionSensing() {
		if (!motionManager.accelerometerActive) {
			motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:accelermeterHandler)
		}
	}
	
	func stopMotionSensing() {
		if (motionManager.accelerometerActive) {
			   motionManager.stopAccelerometerUpdates()
		}
	}
    
    func doTransferAPI() {
        let mufgApiLogic = MufgApiLogic()
        
        let logic:NSData -> Void = {result in
            print("transfer done!")
            
            let logic_:NSData -> Void = {result2 in
                print("approval done!")
            }
            mufgApiLogic.sendApproveRequest("3453746760", callback: logic_)
        }
        mufgApiLogic.sendTransferRequest("3453746760", toAccountId: "3450500775", amount: 1000, callback: logic)
    }
	
	func accelermeterHandler(data:CMAccelerometerData?, error:NSError?) -> Void {
		let acceleration = data!.acceleration
		let x = acceleration.x
		let y = acceleration.y
		let z = acceleration.z
		let m = sqrt(x * x + y * y + z * z)
		if m > 5 {
			print(m)
            var player:AVAudioPlayer?
            
        let soundPath = (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("coin.wav")
        let url:NSURL? = NSURL.fileURLWithPath(soundPath)
            player = try? AVAudioPlayer(contentsOfURL:url!)
            player?.play()
            
            
            //API start
            doTransferAPI()
            
			motionManager.stopAccelerometerUpdates()
			
			let mainStoryboard: UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
	        let receiptViewController = mainStoryboard.instantiateViewControllerWithIdentifier("receiptViewControllerID")
    	    self.presentViewController(receiptViewController, animated: true) { () -> Void in
        	    print("Show receiptViewController")
        	}
		}
	}

}
