//
//  ChargeViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ChargeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func charge(sender: UIButton) {
        print("charge!")
        if !PeripheralManager.isAdvertising() {
            print("charge!!")
            PeripheralManager.startAdvertising()
        }
    }

}
