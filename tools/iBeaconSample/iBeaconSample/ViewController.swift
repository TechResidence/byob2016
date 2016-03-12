//
//  ViewController.swift
//  iBeaconSample
//
//  Created by Koki Shibata on 3/12/16.
//  Copyright © 2016 Koki Shibata. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    
    let ud = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var myUserTextView: UITextView!
    @IBOutlet weak var MyAccount: UITextView!
    
    let colors:[UIColor] = [
        UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fetchAccountDetail(sender: AnyObject) {
        
        let token = ud.objectForKey("token") as! String
        
        // create the url-request
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/3457406176"
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let auth = "Bearer " + token
        print(auth)
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let session: NSURLSession = NSURLSession.sharedSession()
        
        
        let completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void = { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(result)
                do {
                    let account = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! Dictionary<String, AnyObject>
                    let accountId = account["account_id"] as! String
                    let balance = account["balance"] as! Int
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.MyAccount.text = ""
                        self.MyAccount.text = self.MyAccount.text + "\n " + "account id: " + accountId
                        
                        self.MyAccount.text = self.MyAccount.text + "\n " + "balance: " + String(balance)
                    }
                    
                    //
                    //                    let headers = json["headers"] as! Dictionary<String, AnyObject>
                    //                    print(headers["Accept"])
                } catch {
                    print(error)
                }
                result
            } else {
                print(error)
            }
        }
        
        // use NSURLSessionDataTask
        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()

    }
    
    
    @IBAction func pushButton(sender: AnyObject) {
        
        let token = ud.objectForKey("token") as! String
        
        // create the url-request
        let urlString = "http://demo-ap08-prod.apigee.net/v1/users/me"
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let auth = "Bearer " + token
        print(auth)
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let session: NSURLSession = NSURLSession.sharedSession()
        
        let completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void = { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(result)
                do {
                    let user = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! Dictionary<String, AnyObject>
                    let userId = user["user_id"] as! String
                    let accounts = user["my_accounts"] as! Array<Dictionary<String, AnyObject>>
                    let accountId = accounts[0]["account_id"] as! String
                    
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.myUserTextView.text = ""
                        self.myUserTextView.text = self.myUserTextView.text + "\n " + "user id: " + userId
                        
                        self.myUserTextView.text = self.myUserTextView.text + "\n " + "account id: " + accountId
                    }
                    
                    //
//                    let headers = json["headers"] as! Dictionary<String, AnyObject>
//                    print(headers["Accept"])
                } catch {
                    print(error)
                }
                result
            } else {
                print(error)
            }
        }
        
        // use NSURLSessionDataTask
        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
    func fetchMyUser(){
        
    }
    
    
    
    //領域に入った時
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter")
        sendLocalNotificationWithMessage("領域に入りました")
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        print(beacons)
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            print(closestBeacon.minor.integerValue)
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
        }
    }
    
    func sendLocalNotificationWithMessage(message: String!) {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }


}

