//
//  VoteViewController.swift
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/15.
//  
//

import UIKit
import AVFoundation

class VoteViewController: UIViewController, ENSideMenuDelegate {
    
    
    
    private var myRightButton: UIBarButtonItem!
    private var myLeftButton: UIBarButtonItem!

    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideMenuController()?.sideMenu?.delegate = self
        myRightButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPoll")
        myRightButton.tag = 2

       // myLeftButton.tag = 1
       // myLeftButton.image = UIImage(named: "hung_03.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
      //  myLeftButton.style = UIBarButtonItemStyle.Plain
        //myRightButton.action = "hogehogehoge:"
        //myLeftButton.target = self
       // self.navigationItem.leftBarButtonItem = myLeftButton
        
     //   self.navigationItem.rightBarButtonItem = myRightButton
        let csvArray = loadCSV("poll")
        print ("\(csvArray)")
        
        let img:UIImage = UIImage(named: csvArray[0])!
        profImageView.image = img
        titleLabel.text = csvArray[1]
        bodyTextView.text = csvArray[2]

        
    }
    @IBAction func addPoll(sender: AnyObject) {
    }
    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }

    
    @IBAction func returnVoteTop(segue: UIStoryboardSegue){}
    

    //CSVファイルの読み込みメソッド。引数にファイル名、返り値にString型の配列。
    func loadCSV(filename :String)->[String]{
        //CSVファイルを格納するための配列を作成
        var csvArray = []
        //CSVファイルの読み込み
        let csvBundle = NSBundle.mainBundle().pathForResource(filename, ofType: "csv")
        
        do {
            //csvBundleのパスを読み込み、UTF8に文字コード変換して、NSStringに格納
            let csvData = try String(contentsOfFile: csvBundle!,
                encoding: NSUTF8StringEncoding)
            //改行コードが"\r"で行なわれている場合は"\n"に変更する
            let lineChange = csvData.stringByReplacingOccurrencesOfString("\r", withString: "\n")
            //"\n"の改行コードで区切って、配列csvArrayに格納する
            csvArray = lineChange.componentsSeparatedByString("\n")
            
        }
        catch {
            print("エラー")
        }
        return csvArray as! [String]
        
    }
    
    var player:AVAudioPlayer?
    
    @IBAction func play(sender: AnyObject) {
        let soundPath = (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("seikyu.mp3")
        let url:NSURL? = NSURL.fileURLWithPath(soundPath)
        player = try? AVAudioPlayer(contentsOfURL:url!)
        player?.play()
    }
}

