//
//  CheckAPIViewController.swift
//  PettyPay
//
//  Created by AsukaKadowaki on 2016/02/23.
//
//

import UIKit
import SwiftyJSON

class CheckAPIViewController: UIViewController {
    
    @IBAction func tapReturn() {
    }
    @IBOutlet weak var zipTextField: UITextField!
    
    @IBAction func tapSearch() {
        guard let ziptext = zipTextField.text else{        return
        }
        let urlStr = "http://api.zipaddress.net/?zipcode=\(ziptext)"
        print(urlStr)
        
        if let url = NSURL(string: urlStr){
            let urlSession = NSURLSession.sharedSession()
            let task = urlSession.dataTaskWithURL(url, completionHandler: self.onGetAddress)
            task.resume()
        }
    }
    
    func onGetAddress(data: NSData?,res: NSURLResponse?,error: NSError?){
        print(data)
        do{
            let jsonDic = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            
            if let code = jsonDic["code"] as? Int{
                if code != 200{
                    if let errmsg = jsonDic["message"] as? String{
                        print(errmsg)
                    }
                }
            }
            if let data = jsonDic["data"] as? NSDictionary{
                if let pref = data["pref"] as? String{
                    print("場所は\(pref)です")
                    dispatch_async(dispatch_get_main_queue()){
                        self.prefLabel.text = pref
                    }
                }
                
            }
        }
        catch{
            print("エラーです")
            dispatch_async(dispatch_get_main_queue()){
                self.prefLabel.text = "エラーです"
            }
        }
    }
    
    @IBOutlet weak var prefLabel: UILabel!
    

}
