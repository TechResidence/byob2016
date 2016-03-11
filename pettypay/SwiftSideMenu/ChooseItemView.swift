//
//  ChooseItemView.swift
//  PettyPay
//
//  Created by AsukaKadowaki on 2016/02/15.
//
//

import UIKit
import MDCSwipeToChoose
import SDWebImage
import QuartzCore

class ChooseItemView: MDCSwipeToChooseView {
    
    let ChooseItemViewImageLabelWidth:CGFloat = 0;
    var item: Item!
    var informationView: UIView!
    var nameLabel: UILabel!
    var carmeraImageLabelView:ImagelabelView!
    var interestsImageLabelView: ImagelabelView!
    var friendsImageLabelView: ImagelabelView!
    var resultButton: UIButton!
    var bkImageLabelView: UIView!
    var bk2ImageLabelView: UIImageView!
    var bk3ImageLabelView: UIView!
    var profView: UIImageView!
    let xButtonCount = 1
    let yButtonCount = 2
    let buttonMargin = 8.0
    let screenWidth:Double = Double(UIScreen.mainScreen().bounds.size.width) - 50
    let screenHeight:Double = Double(UIScreen.mainScreen().bounds.size.height) - 100
    var button = UIButton()
    var contentsLabel: UILabel!
    
    required init(frame: CGRect, item: Item, options: MDCSwipeToChooseViewOptions) {
        super.init(frame: frame, options: options)
        self.backgroundColor = UIColor.whiteColor()
        self.item = item
        self.imageView.sd_setImageWithURL(NSURL(string: item.imageUrl))
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        //| UIViewAutoresizing.FlexibleWidth UIViewAutoresizing.FlexibleBottomMargin
        self.imageView.autoresizingMask = self.autoresizingMask
        self.imageView = UIImageView(frame:frame)
        
        
        constructInformationView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    func constructInformationView() -> Void{
        let infoFrame:CGRect = CGRectMake(0,
            0,
            CGRectGetWidth(bounds),
            CGRectGetHeight(bounds))
        informationView = UIView(frame:infoFrame)
        informationView.backgroundColor = UIColor.whiteColor()
        informationView.clipsToBounds = true
        informationView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        addSubview(informationView)
        
        
  //      constructBack3ImageLabelView()
  //      constructBackImageLabelView()
  //      constructBack2ImageLabelView()
        constructProfView()
        constructButtonView()
        constructNameLabel()
        constructContentsLabel()
    }
    

    
    func constructNameLabel() -> Void {
        let leftPadding:CGFloat = 85.0
        let topPadding:CGFloat = 60.0
        let frame:CGRect = CGRectMake(leftPadding,
            topPadding,
            200,
            30)
        nameLabel = UILabel(frame:frame)
        nameLabel.backgroundColor = UIColor.whiteColor()
        nameLabel.text = item.title
        self.informationView .addSubview(self.nameLabel)
    }
    
    func constructContentsLabel() -> Void {
        let leftPadding:CGFloat = 50.0
        let topPadding:CGFloat = 110.0
        let frame:CGRect = CGRectMake(leftPadding,
            topPadding,
            200,
            100)
        contentsLabel = UILabel(frame:frame)
        contentsLabel.backgroundColor = UIColor.whiteColor()
        contentsLabel.text = item.contents
        self.informationView .addSubview(self.contentsLabel)
    }
    
    func constructProfView() -> Void{

       // profView.backgroundColor = UIColor.greenColor()

        let url = NSURL(string: item.imageUrl)
        var err: NSError?
        print("\(url)")
        let imgData: NSData
        do {
            imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let img = UIImage(data:imgData);
            var profView = UIImageView(image:img);
            print("\(profView)")
     /*       let leftPadding:CGFloat = 25.0
            let topPadding:CGFloat = 50.0
            let width:CGFloat = 50
            let height:CGFloat = 50
            let frame:CGRect = CGRectMake(leftPadding,
                topPadding,
                width,
                height)
            //imgView.frame = CGRectMake(25, 50, 50, 50);
            profView = UIImageView(frame: frame)*/
            profView.frame = CGRectMake(25, 50, 50, 50);
            addSubview(profView)
        } catch {
            print("Error: can't create image.")
        }
        
        
        //
       // profView.backgroundColor = UIColor.greenColor()
        //profView.image = UIImage(named: "poll_prof.png")

    }

    func constructButtonView() -> Void{
        
        for var y = 0; y < yButtonCount; y++ {
            for var x = 0; x < xButtonCount; x++ {
        let button = UIButton()
        let buttonWidth = ( screenWidth - ( buttonMargin * ( Double(xButtonCount) + 1 ) ) ) / Double(xButtonCount)
        let buttonHeight = ( screenHeight - 300 - ( ( buttonMargin * Double(yButtonCount) + 1 ) ) ) / Double(yButtonCount)
        let buttonPositionX = 15 + ( screenWidth - buttonMargin ) / Double(xButtonCount) * Double(x) + buttonMargin
        let buttonPositionY = ( screenHeight - 300 - buttonMargin ) / Double(yButtonCount) * Double(y) + buttonMargin + 200
        button.frame = CGRect(x:buttonPositionX,y: buttonPositionY,width:buttonWidth,height:buttonHeight)
        print("PosiX=\(buttonPositionX)")
        print("PosiY=\(buttonPositionY)")
        print("BTW=\(buttonWidth)")
        print("x=\(x)")
        print("y=\(y)")
        button.backgroundColor = UIColor.greenColor()
        // ボタンタップ時のアクション設定
        //button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(button)
        
            }
        }
        
        
    }

        
        

    
    
    func constructBackImageLabelView() -> Void {
        
        let image:UIImage = UIImage(named:"bk")!
       // bkImageLabelView.backgroundColor = UIColor.greenColor()
        self.bkImageLabelView = self.buildImageLabelView(CGRectGetWidth(informationView.bounds), image: image, text:"")
        self.informationView.addSubview(self.bkImageLabelView)
    }
    
    func constructBack3ImageLabelView() -> Void {
        let image: UIImage = UIImage(named: "View-From-Diamond-Head-Oahu-Hawaii")!
        self.bk3ImageLabelView = self.buildImageLabelView(CGRectGetWidth(informationView.bounds), image: image, text:"")
        self.informationView.addSubview(self.bk3ImageLabelView)
    }
    
    func constructBack2ImageLabelView() -> Void {
       // let image: UIImage = UIImage(named: "bk2")!
        let leftPadding:CGFloat = 20.0
        let frame:CGRect = CGRectMake(0,
            -70,
            (width: (UIScreen.mainScreen().bounds.size.width) - leftPadding),
            (height: (UIScreen.mainScreen().bounds.size.height)))
        bk2ImageLabelView = UIImageView(frame: frame)
        bk2ImageLabelView.image = UIImage(named: "bk2.png")
        self.informationView.addSubview(self.bk2ImageLabelView)
    }
    
    func buildImageLabelView(x:CGFloat, image:UIImage, text:String) -> ImagelabelView {
       // let screenWidth:Double = Double(UIScreen.mainScreen().bounds.size.width)
       // let frame:CGRect = CGRect(x:60, y: 0,
       //     width: ChooseItemViewImageLabelWidth,
        let frame:CGRect = CGRect(x:0, y: -10,
            width: (UIScreen.mainScreen().bounds.size.width) - 20,
            height: (UIScreen.mainScreen().bounds.size.height) - 20)
          //  height: CGRectGetHeight(self.informationView.bounds))
        let view:ImagelabelView = ImagelabelView(frame:frame, image:image, text:text)
        view.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
        return view
    }
    
}

