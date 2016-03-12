//
//  WebAPIViewController.swift
//  iBeaconSample
//
//  Created by Koki Shibata on 3/12/16.
//  Copyright © 2016 Koki Shibata. All rights reserved.
//

import UIKit

class WebAPIViewController: UIViewController, WebActionDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let targetURL = "https://demo-ap08-prod.apigee.net/oauth/authorize?redirect_uri=myapp://app&client_id=GcGqiJ5UrwK8wpEomuhghVLZnknCRWtW&response_type=token"
        // 初期化したURLを読み込む
        let requestURL = NSURL(string: targetURL)
        
        // 読み込んだURLの実行結果を取得する
        let req = NSURLRequest(URL:requestURL!)
        
        webView.loadRequest(req)
        webView.scalesPageToFit = true
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func modalDidFinished(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("dismiss")
        }
    }
    
}
