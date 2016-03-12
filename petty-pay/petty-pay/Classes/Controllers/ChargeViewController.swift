//
//  ChargeViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ChargeViewController: UIViewController {
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var numberOfItemsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(recognizer)
    }
    
    func dismissKeyboard() {
        itemNameTextField.resignFirstResponder()
        numberOfItemsTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
    }
    
    @IBAction func charge(sender: UIButton) {
        print("charge!")
        if !PeripheralManager.isAdvertising() {
            print("charge!!")
            PeripheralManager.startAdvertising()
        }
    }
    
}
