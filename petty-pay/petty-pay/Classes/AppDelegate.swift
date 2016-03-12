//
//  AppDelegate.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
import CoreMotion

protocol WebActionDelegate{
    func modalDidFinished()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
    var delegate: WebActionDelegate! = nil
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        sleep(2);
        
        // ユーザのpush通知許可をもらうための設定
        application.registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes:
                [UIUserNotificationType.Sound
                    , UIUserNotificationType.Badge
                    , UIUserNotificationType.Alert], categories: nil)
        )
        
        locationManager.delegate = self;
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        
        PeripheralManager.checkStateOfAdvertising()
        
        // Create Region
        let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "pettypay")
        locationManager.startMonitoringForRegion(region)
        
        // アプリを終了していた際に、通知からの復帰をチェック
        if let notification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification {
            localPushRecieve(application, notification: notification)
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //
    // Notification handling
    //
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // アプリがActiveな状態で通知を発生させた場合にも呼ばれるのでActiveでない場合のみ実行するように
        // Ref: https://blog.hello-world.jp.net/ios/3542/
        localPushRecieve(application, notification: notification)
    }
    
    func localPushRecieve(application: UIApplication, notification: UILocalNotification) {
        openConfirmationView()
    }
    
    func openConfirmationView() {
        let paymentStoryboard: UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let paymentViewController = paymentStoryboard.instantiateViewControllerWithIdentifier("paymentViewControllerID") as! PaymentViewController
        
        if let rootViewController = self.window?.rootViewController {
            rootViewController.presentViewController(paymentViewController, animated: true, completion: { () -> Void in
                print("Open paymentViewController")
            })
        } else {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainTabViewControllerID") as! MainTabViewController
            mainTabViewController.showAlert()
        }
    }
    
    // ----------------------------------------
    // Monitoring
    // ----------------------------------------
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("Start Monitoring Region")
        //        sendLocalNotificationForMessage("Start Monitoring Region")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("locationManager failed: %@", error)
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter Region")
        sendLocalNotificationForMessage("支払いの請求がありました")
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
    
    func sendLocalNotificationForMessage(message: String!) {
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = message
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    // Custom URL shceme
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        print(url.fragment)
        
        let ss = NSString(string: url.fragment!)
        let sss:String = ss.substringFromIndex(37)
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(sss, forKey: "token")
        
        //        let viewController = ViewController()
        //        self.dis
        self.delegate.modalDidFinished()
        
        return true
    }
}

