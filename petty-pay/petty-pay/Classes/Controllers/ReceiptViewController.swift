//
//  ReceiptViewController.swift
//  petty-pay
//
//  Created by Kotaro Kamiya on 3/13/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit
import CoreLocation


class ReceiptViewController: UIViewController, CLLocationManagerDelegate {
    let ud = NSUserDefaults.standardUserDefaults()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func exit(sender: AnyObject) {

//	    if(region.isMemberOfClass(CLBeaconRegion) && CLLocationManager.isRangingAvailable()) {
//            locationManager.startRangingBeaconsInRegion(region)
//        }
		StoryboadHopper.showMain(self)
	}
}
