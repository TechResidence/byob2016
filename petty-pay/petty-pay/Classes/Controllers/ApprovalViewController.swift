//
//  ApprovalViewController.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaultPurchases: [Purchase] = [
        Purchase(
            user: User(name: "小口元気", type: "営業", image: UIImage(named: "prof01")!),
            item: Item(name: "接待費", type: "購入", price: 3000)
        ),
        Purchase(
            user: User(name: "花田蜜子", type: "秘書", image: UIImage(named: "prof03")!),
            item: Item(name: "お菓子", type: "購入", price: 1000)
        ),
        Purchase(
            user: User(name: "中村太郎", type: "R&D", image: UIImage(named: "prof02")!),
            item: Item(name: "参考書", type: "R&D", price: 3000)
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultPurchases.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let approvalTableViewCell = tableView.dequeueReusableCellWithIdentifier("approvalTableViewCellID", forIndexPath: indexPath) as! ApprovalTableViewCell
        let purchase = defaultPurchases[indexPath.row]
        approvalTableViewCell.construct(purchase)
        return approvalTableViewCell
    }
    
}
