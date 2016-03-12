//
//  PaymentViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit
import CoreMotion

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
	
	func accelermeterHandler(data:CMAccelerometerData?, error:NSError?) -> Void {
		let acceleration = data!.acceleration
		let x = acceleration.x
		let y = acceleration.y
		let z = acceleration.z
		let m = sqrt(x * x + y * y + z * z)
		if m > 5 {
			print(m)
			print("Go to Ryoshu-sho page")
			motionManager.stopAccelerometerUpdates()
			
			let mainStoryboard: UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
	        let receiptViewController = mainStoryboard.instantiateViewControllerWithIdentifier("receiptViewControllerID")
    	    self.presentViewController(receiptViewController, animated: true) { () -> Void in
        	    print("Show receiptViewController")
        	}
		}
	}

}
