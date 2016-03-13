//
//  PaymentViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class PaymentViewController: UIViewController {
    
    // Create Motion Manager and Handler
    let motionManager = CMMotionManager()
    var _ssId01:SystemSoundID = 0
    var flag = false
    
    var shakeFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startMotionSensing()
        doReady()
    }
    
    func doReady(){
        // 音楽ファイルの参照
        let bnd:NSBundle = NSBundle.mainBundle()
        
        // 設定#01
        let url01 = NSURL(fileURLWithPath: bnd.pathForResource("coin", ofType: "wav")!)
        
        AudioServicesCreateSystemSoundID(url01, &_ssId01)
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
    
    func changeAPI() {
        let mufgApiLogic = MufgApiLogic()
        
        let logic:NSData -> Void = {result in
            print("change done!------------")
        }
        mufgApiLogic.sendChangeStatus(logic)
    }
    
    func doTransferAPI() {
        let mufgApiLogic = MufgApiLogic()
        
        let logic:NSData -> Void = {result in
            print("transfer done!")
            
            let logic_:NSData -> Void = {result2 in
                print("approval done!")
            }
            mufgApiLogic.sendApproveRequest("3453746760", callback: logic_)
        }
        mufgApiLogic.sendTransferRequest("3453746760", toAccountId: "3450500775", amount: 1000, callback: logic)
    }
    
    func accelermeterHandler(data:CMAccelerometerData?, error:NSError?) -> Void {
        let acceleration = data!.acceleration
        let x = acceleration.x
        let y = acceleration.y
        let z = acceleration.z
        let m = sqrt(x * x + y * y + z * z)

        if m > 5 {
            if !flag{
                flag = true
                print(m)
                
                //API start
                doTransferAPI()
                
                //柴田のserverに繋ぐ用。使わなければcomment out
                changeAPI()
                
                AudioServicesPlaySystemSound(_ssId01)
                sleep(1)
                
                motionManager.stopAccelerometerUpdates()
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
                let receiptViewController = mainStoryboard.instantiateViewControllerWithIdentifier("receiptViewControllerID")
                self.presentViewController(receiptViewController, animated: true) { () -> Void in
                    print("Show receiptViewController")
                }
            }
        }
    }
}
