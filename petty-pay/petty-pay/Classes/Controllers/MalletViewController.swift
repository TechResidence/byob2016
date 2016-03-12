//
//  MalletViewController.swift
//  mallet
//
//  Created by Kotaro Kamiya on 3/12/16.
//  Copyright © 2016 pettypay. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
import CoreMotion

class MalletViewController: UIViewController, CLLocationManagerDelegate, UIAlertViewDelegate {

	// Create Managers
	let motionManager = CMMotionManager()
	let peripheralManager = PeripheralManager()
    let locationManager = CLLocationManager()

	// Setting Managers
	// motionManager.accelerometerUpdateInterval = 0.01;

	// Create Region
	let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "pettypay")
	
	// Create Motion Handler
	let accelermeterHandler:CMAccelerometerHandler = {(data:CMAccelerometerData?, error:NSError?) -> Void in
		let acceleration = data!.acceleration
		let x = acceleration.x
		let y = acceleration.y
		let z = acceleration.z
		let m = sqrt(x * x + y * y + z * z)
		if m > 5 {
			print(m)
			if !PeripheralManager.isAdvertising() {
				PeripheralManager.startAdvertising()
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	    locationManager.delegate = self;
		if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
			locationManager.requestAlwaysAuthorization()
		}
		if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
			locationManager.requestWhenInUseAuthorization()
		}
		PeripheralManager.checkStateOfAdvertising()
		locationManager.startMonitoringForRegion(region)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// ----------------------------------------
	// Local Notification and Alert
	// ----------------------------------------

	func sendLocalNotificationForMessage(message: String!) {
		let localNotification:UILocalNotification = UILocalNotification()
		localNotification.alertBody = message
		localNotification.soundName = UILocalNotificationDefaultSoundName
  		UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
	}
	
	func showAlert() {
		var alert = UIAlertView()
		alert.title = "Thank you"
		alert.message = "your claim is paied"
		alert.addButtonWithTitle("OK")
		alert.show()
	}

	// ----------------------------------------
	// Advertising
	// ----------------------------------------

	@IBOutlet weak var advertiseSwitch: UISwitch!
	@IBAction func advertise(sender: UISwitch) {
		if(advertiseSwitch.on) {
			print("on!")
			locationManager.stopMonitoringForRegion(region)
			motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:accelermeterHandler)
		} else {
			print("off!")
			PeripheralManager.stopAdvertising()
			locationManager.startMonitoringForRegion(region)
			if (motionManager.accelerometerActive) {
 			   motionManager.stopAccelerometerUpdates()
			}
		}
	}

	// ----------------------------------------
	// Monitoring
	// ----------------------------------------
	
	func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
		print("Start Monitoring Region")
		sendLocalNotificationForMessage("Start Monitoring Region")
	}
	
	func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
		print("Enter Region")
		sendLocalNotificationForMessage("Enter Region")
		if(region.isMemberOfClass(CLBeaconRegion) && CLLocationManager.isRangingAvailable()) {
			locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
 		}
	}
	
	func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
		print("Exit Region")
		sendLocalNotificationForMessage("Exit Region")
		if(region.isMemberOfClass(CLBeaconRegion)) {
			locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
 		}
	}

	// ----------------------------------------
	// Ranging
	// ----------------------------------------
	
	func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
		// let proximities = beacons.map({x in x.proximity.rawValue})
		if let beacon = beacons.first {
			if (beacon.proximity == CLProximity.Immediate || beacon.proximity == CLProximity.Near) {
				// Immediate 1, Near 2, Far 3, Unknown 0
				print(beacon)
				showAlert()
				if(region.isMemberOfClass(CLBeaconRegion)) {
				    print("Stop Ranging")
					locationManager.stopRangingBeaconsInRegion(region)
				}
			}
		}
	}
	
}

