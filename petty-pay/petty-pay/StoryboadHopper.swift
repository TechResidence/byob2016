//
//  StoryboadHopper.swift
//  petty-pay
//
//  Created by Kotaro Kamiya on 3/13/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class StoryboadHopper: UIViewController {

    // private static let sharedInstance = StoryboadHopper()

    static func showMain(controller: UIViewController) {
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let mainTabViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainTabViewControllerID")
		controller.presentViewController(mainTabViewController, animated: true) { () -> Void in
        	    print("Show mainTabViewController")
		}
	}
}

extension StoryboadHopper {

    func f() {
    }
}