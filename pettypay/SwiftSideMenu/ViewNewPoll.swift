//
//  ViewNewPoll.swift
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/14.
//  Copyright © 2016年 Evgeny Nazarov. All rights reserved.
//

import UIKit


class ViewNewPoll: UIViewController, ENSideMenuDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    //    func sideMenuWillOpen() {
    //        print("sideMenuWillOpen")
    //    }
    

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
    @IBAction func question(sender: AnyObject) {
    }
    
    @IBAction func group(sender: AnyObject) {
    }
    
    @IBAction func returnTop(segue: UIStoryboardSegue){}
    
    
}

