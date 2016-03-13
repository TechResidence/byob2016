//
//  
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/15.
//  
//

import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}
