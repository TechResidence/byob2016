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
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Management", bundle: nil)
		let managementViewController = mainStoryboard.instantiateViewControllerWithIdentifier("managementViewControllerID")
		self.presentViewController(managementViewController, animated: true) { () -> Void in
        	    print("Show managementViewController")
        	}

	}
}
