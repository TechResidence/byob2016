//
//  MufgApiLogic.swift
//  petty-pay
//
//  Created by Koki Shibata on 3/13/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class MufgApiLogic: NSObject {
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    func sendApproveRequest(accountId: String, callback: Dictionary<String, AnyObject> -> Void){
        
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + accountId + "/transfers?action=approve"
        let completionHandler = self.createCompletionHandler(callback)
        
        let payee = NSDictionary(dictionary: ["bank_name": "", "branch_name": "", "account_type": "", "account_id": "ss", "name": ""])
        let dict = NSDictionary(dictionary: ["amount": 1000, "payee": payee])
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
            self.postHttpRequest(urlString, postData: data, completionHandler: completionHandler)
        } catch {
            print(error)
        }
    }
    
    func sendTransferRequest(fromAccountId: String, toAccountId: String, amount:Int, callback: Dictionary<String, AnyObject> -> Void){
        
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + fromAccountId + "/transfers"
        let completionHandler = self.createCompletionHandler(callback)
        
        let payee = NSDictionary(dictionary: ["bank_name": "", "branch_name": "", "account_type": "", "account_id": toAccountId, "name": ""])
        let dict = NSDictionary(dictionary: ["amount": 1000, "payee": payee])
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
            self.postHttpRequest(urlString, postData: data, completionHandler: completionHandler)
        } catch {
            print(error)
        }
    }
    
    func postHttpRequest(url:String, postData: NSData, completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void)->Void{
        let token = ud.objectForKey("token") as! String
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
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
    
    func fetchAccountDetail(accountId: String, callback: Dictionary<String, AnyObject> -> Void){
        let urlString = "http://demo-ap08-prod.apigee.net/v1/accounts/" + accountId
        let completionHandler = createCompletionHandler(callback)
        getHttpRequest(urlString, completionHandler: completionHandler)
    }
    
    func fetchMe(callback: Dictionary<String, AnyObject> -> Void){
        let urlString = "http://demo-ap08-prod.apigee.net/v1/users/me"
        
        let completionHandler = createCompletionHandler(callback)
        
        getHttpRequest(urlString, completionHandler: completionHandler)
    }
    
    func getHttpRequest(url:String, completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void)->Void{
        let token = ud.objectForKey("token") as? String
        
        if token == nil {
            return
        }
        
        // create the url-request
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let auth = "Bearer " + token!
        print(auth)
        request.addValue(auth, forHTTPHeaderField: "Authorization")
        
        let session: NSURLSession = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
    func createCompletionHandler(logic: Dictionary<String, AnyObject> -> Void)-> (NSData?, NSURLResponse?, NSError?)-> Void{
        let completionHandler: (NSData?, NSURLResponse?, NSError?)-> Void = { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                
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
