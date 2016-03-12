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

        // Do any additional setup after loading the view.
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
