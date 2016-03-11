//
//  DoneViewController.swift
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/03/10.
//  Copyright © 2016年 Evgeny Nazarov. All rights reserved.
//

import UIKit
import AVFoundation

class DoneViewController: UIViewController {
    
    var player:AVAudioPlayer?
    
    @IBAction func play(sender: AnyObject) {
        let soundPath = (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("coin.wav")
        let url:NSURL? = NSURL.fileURLWithPath(soundPath)
        player = try? AVAudioPlayer(contentsOfURL:url!)
        player?.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
