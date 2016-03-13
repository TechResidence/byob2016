//
//  ViewController.swift
//  iBeaconSample
//
//  Created by Koki Shibata on 3/12/16.
//  Copyright © 2016 Koki Shibata. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    var _ssId01:SystemSoundID = 0
    
    let ud = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var myUserTextView: UITextView!
    @IBOutlet weak var MyAccount: UITextView!
    @IBOutlet weak var transferTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doReady()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doReady(){
        
        print("サウンド")
        
        // 音楽ファイルの参照
        let bnd:NSBundle = NSBundle.mainBundle()
        
        // 設定#01
        let url01 = NSURL(fileURLWithPath: bnd.pathForResource("coin", ofType: "wav")!)
        
        AudioServicesCreateSystemSoundID(url01, &_ssId01)
        AudioServicesPlaySystemSound ( _ssId01 )
        
        print("サウンド2")
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
        
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + "3453829144" + "/transfers"
        let completionHandler = self.createCompletionHandler(callback)
        
        let payee = NSDictionary(dictionary: ["bank_name": "三菱東京UFJ銀行", "branch_name": "渋谷中央支店", "account_type": "普通", "account_id": toAccountId, "name": "action"])
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
        
        print("play sound")
        
        AudioServicesPlaySystemSound(_ssId01)
        
//        let logic:Dictionary<String, AnyObject> -> Void = {result in
//            print(result)
//            dispatch_async(dispatch_get_main_queue()) {
//                self.transferTextView.text = "done"
//            }
//        }
//        self.sendTransferRequest("3453829144", toAccountId: "7406176", amount: 1000, callback: logic)
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
    
}

