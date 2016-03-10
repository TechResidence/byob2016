//
//  ViewResult.swift
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/14.
//
//

import UIKit

class ViewResult: UIViewController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        /*
        let barChartView = JBBarChartView();
        barChartView.dataSource = self;
        barChartView.delegate = self;
        barChartView.backgroundColor = UIColor.darkGrayColor();
        barChartView.frame = CGRectMake(0, 20, self.view.bounds.width, self.view.bounds.height * 0.5);
        barChartView.reloadData();
        self.view.addSubview(barChartView);
        print("Launched");
        */
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
        func sideMenuWillClose() {
            print("sideMenuWillClose")
        }
    
        func sideMenuShouldOpenSideMenu() -> Bool {
            print("sideMenuShouldOpenSideMenu")
            return true
        }
    
        func sideMenuDidClose() {
            print("sideMenuDidClose")
        }
    
        func sideMenuDidOpen() {
            print("sideMenuDidOpen")
        }
    
    @IBAction func returnTop(segue: UIStoryboardSegue){}
    /*
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        print("numberOfBarsInBarChartView");
        return 10 //number of lines in chart
    }
    
    func barChartView(barChartView: JBBarChartView, heightForBarViewAtIndex index: UInt) -> CGFloat {
        print("barChartView", index);
        
        return CGFloat(arc4random_uniform(100));
    }
    */
    
}

    

    

    


