//
//  UIKitExtensions.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/11/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class TextField: UITextField {
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            let canEditPlaceholderColor = self.respondsToSelector(Selector("setAttributedPlaceholder:"))
            if (canEditPlaceholderColor) {
                self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes:[NSForegroundColorAttributeName: placeholderColor])
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var insetX: CGFloat = 0
    
    // Placeholder position
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, insetX, 0)
    }
    
    // Text position
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX, 0)
    }
}

@IBDesignable class Button: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

extension UIColor {
    
    class func background() -> UIColor {
        return UIColor(red: 44.0/255, green: 62.0/255, blue: 80.0/255, alpha: 1.0)
    }
    class func xoRed() -> UIColor {
        return UIColor(red: 228.0/255, green: 75.0/255, blue: 59.0/255, alpha: 1.0)
    }
    class func xoWhite() -> UIColor {
        return UIColor(red: 236.0/255, green: 240.0/255, blue: 241.0/255, alpha: 1.0)
    }
    class func xoLightBlue() -> UIColor {
        return UIColor(red: 52.0/255, green: 152.0/255, blue: 219.0/255, alpha: 1.0)
    }
    class func xoDarkBlue() -> UIColor {
        return UIColor(red: 41.0/255, green: 128.0/255, blue: 185.0/255, alpha: 1.0)
    }
}