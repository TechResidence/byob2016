//
//  ManagementViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ManagementViewController: UIViewController {
    
    let logic = MufgApiLogic()

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let logic:Dictionary<String, AnyObject> -> Void = { user in
            print(user)
            let accounts = user["my_accounts"] as! Array<Dictionary<String, AnyObject>>
            let accountId = accounts[0]["account_id"] as! String
            let userName = user["user_name"] as! String
            
            let logic_:Dictionary<String, AnyObject> -> Void = {account in
                let balance = account["balance"] as! Int
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.amountLabel.text = "¥" + String(balance)
                    self.userLabel.text = userName
                    self.dateLabel.text = "2016/03/12"
                }
            }
            self.logic.fetchAccountDetail(accountId, callback: logic_)
        }
        
        self.logic.fetchMe(logic)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
