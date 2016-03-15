//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/13.
//
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    
    let groupNames = ["menu"]
    let groups = [["ALL", "For you", "Popular", "Created By you", "Answered By you", "Dissmissed By you", "closed", "To Project Beta", "To Koki Shibata", "From Kota Kamiya", "From Aki Sumida", "Eichiro", "Sign out"]]
    let prof = UIImage(named: "poll_prof")
    
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return self.groupNames.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.groups[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
       // cell!.textLabel?.text = "ViewController #\(indexPath.row+1)"
        cell!.textLabel?.text = self.groups[indexPath.section][indexPath.row]
        

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ALL")
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
        case 3:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
            
        case 4:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break

        case 5:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
    
        case 6:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
    
        case 7:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
            
        case 8:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break

        case 9:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
            
        case 10:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sample")
            break
            
            
        case 11:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SignUp")
            break
            
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SignIn")
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
