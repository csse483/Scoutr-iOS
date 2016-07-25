//
//  HomeScreenButton.swift
//  Scoutr
//
//  Created by CSSE Department on 7/25/16.
//  Copyright © 2016 Rose Hulman. All rights reserved.
//

import UIKit

class HomeScreenButton: UIButton {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
            layer.borderWidth = 1
            layer.cornerRadius = 5
        }
    }
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
