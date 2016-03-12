//
//  ReceiptViewController.swift
//  petty-pay
//
//  Created by Kotaro Kamiya on 3/13/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func exit(sender: AnyObject) {
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let mainTabViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainTabViewControllerID")
		self.presentViewController(mainTabViewController, animated: true) { () -> Void in
        	    print("Show mainTabViewController")
        	}

	}
}
