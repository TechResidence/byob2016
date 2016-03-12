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
    @IBOutlet weak var transferTextView: UITextView!
    
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
    
    func postHttpRequest(url:String, postData: NSData, completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void)->Void{
        let token = ud.objectForKey("token") as! String
        
        // create the url-request
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = postData
        
        let auth = "Bearer " + token
        //        print(auth)
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let session: NSURLSession = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
    func getHttpRequest(url:String, completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void)->Void{
        let token = ud.objectForKey("token") as! String
        
        // create the url-request
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let auth = "Bearer " + token
        print(auth)
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let session: NSURLSession = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
    func fetchAccountDetail(accountId: String, callback: Dictionary<String, AnyObject> -> Void){
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + accountId
        let completionHandler = createCompletionHandler(callback)
        self.getHttpRequest(urlString, completionHandler: completionHandler)
    }
    
    func sendTransferRequest(fromAccountId: String, toAccountId: String, amount:Int, callback: Dictionary<String, AnyObject> -> Void){
        
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + fromAccountId + "/transfers"
        let completionHandler = createCompletionHandler(callback)
        
        let payee = NSDictionary(dictionary: ["bank_name": "三菱東京UFJ銀行", "branch_name": "渋谷中央支店", "account_type": "普通", "account_id": "7406176", "name": "action"])
        let dict = NSDictionary(dictionary: ["amount": 1000, "payee": payee])
        
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
            self.postHttpRequest(urlString, postData: data, completionHandler: completionHandler)
        } catch {
            print(error)
        }
    }
    
    @IBAction func fetchAccountDetail(sender: AnyObject) {
        
        let logic:Dictionary<String, AnyObject> -> Void = { user in
            let accounts = user["my_accounts"] as! Array<Dictionary<String, AnyObject>>
            let normalAccouts = accounts.filter({ (account) -> Bool in
                let type = account["account_type"] as! String
                return type == "普通"
            })
            let accountId = normalAccouts[0]["account_id"] as! String
            
            let logic_:Dictionary<String, AnyObject> -> Void = {account in
                let accountId = account["account_id"] as! String
                let balance = account["balance"] as! Int
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.MyAccount.text = ""
                    self.MyAccount.text = self.MyAccount.text + "\n " + "account id: " + accountId
                    self.MyAccount.text = self.MyAccount.text + "\n " + "balance: " + String(balance)
                }
            }
            self.fetchAccountDetail(accountId, callback: logic_)
        }
        
        self.fetchMe(logic)
    }
    
    
    @IBAction func transfer(sender: AnyObject) {
        
//        let logic:Dictionary<String, AnyObject> -> Void = { json in
//            let accounts = json["entities"] as! Array<Dictionary<String, AnyObject>>
//            let normalAccouts = accounts.filter({ (account: Dictionary<String, AnyObject>) -> Bool in
//                let type = account["account_type"] as! String
//                return type == "普通"
//            }).sort({ (a1, a2) -> Bool in
//                let id1 = a1["account_id"] as! String
//                let id2 = a2["account_id"] as! String
//                return id1 < id2
//            })
//            let accountId1 = normalAccouts[0]["account_id"] as! String
//            let accountId2 = normalAccouts[1]["account_id"] as! String
            
            let logic_:Dictionary<String, AnyObject> -> Void = {result in
                print(result)
                dispatch_async(dispatch_get_main_queue()) {
                    self.MyAccount.text = "done"
                }
            }
//            self.sendTransferRequest(accountId1, toAccountId: accountId2, amount: 1000, callback: logic_)
            
            let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + "3453829144" + "/transfers"
            let completionHandler = self.createCompletionHandler(logic_)
            
            let payee = NSDictionary(dictionary: ["bank_name": "三菱東京UFJ銀行", "branch_name": "渋谷中央支店", "account_type": "普通", "account_id": "7406176", "name": "action"])
            let dict = NSDictionary(dictionary: ["amount": 1000, "payee": payee])
            
        var data:NSData? = nil
            do {
                data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
//                self.postHttpRequest(urlString, postData: data, completionHandler: completionHandler)
                
            } catch {
                print(error)
            }
        
        let token = ud.objectForKey("token") as! String
        
        // create the url-request
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = data!
        
        let auth = "Bearer " + token
        //        print(auth)
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let session: NSURLSession = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
        
//        }
//        self.fetchAllAccounts(logic)
    }
    
    func fetchMe(callback: Dictionary<String, AnyObject> -> Void){
        let urlString = "http://demo-ap08-prod.apigee.net/v1/users/me"
        
        let completionHandler = createCompletionHandler(callback)
        
        self.getHttpRequest(urlString, completionHandler: completionHandler)
    }
    
    func fetchAllAccounts(callback: Dictionary<String, AnyObject> -> Void){
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts"
        
        let completionHandler = createCompletionHandler(callback)
        
        self.getHttpRequest(urlString, completionHandler: completionHandler)
    }
    
    @IBAction func pushButton(sender: AnyObject) {
        let logic:Dictionary<String, AnyObject> -> Void = { user in
            let userId = user["user_id"] as! String
            let accounts = user["my_accounts"] as! Array<Dictionary<String, AnyObject>>
            print(accounts)
            let accountId = accounts[0]["account_id"] as! String
            
            
            dispatch_async(dispatch_get_main_queue()) {
                self.myUserTextView.text = ""
                self.myUserTextView.text = self.myUserTextView.text + "\n " + "user id: " + userId
                
                self.myUserTextView.text = self.myUserTextView.text + "\n " + "account id: " + accountId
            }
        }
        self.fetchMe(logic)
    }
    
    func createCompletionHandler(logic: Dictionary<String, AnyObject> -> Void)-> (NSData?, NSURLResponse?, NSError?)-> Void{
        let completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void = { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(result)
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! Dictionary<String, AnyObject>
                    logic(json)
                } catch {
                    print(error)
                }
                result
            } else {
                print(error)
            }
        }
        return completionHandler
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

