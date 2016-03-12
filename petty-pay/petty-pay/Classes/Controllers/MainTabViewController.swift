//
//  MainTabViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController, UIAlertViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let ud = NSUserDefaults.standardUserDefaults()
        let token = ud.objectForKey("token") as? String
        
        if let _ = token {
            return
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let webAPIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("webAPIViewControllerID") as! WebAPIViewController
        self.presentViewController(webAPIViewController, animated: true) { () -> Void in
            print("Show webAPIViewController")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For debug
    func showAlert() {
        let alert = UIAlertView()
        alert.title = "Thank you"
        alert.message = "your claim is paied"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
}
