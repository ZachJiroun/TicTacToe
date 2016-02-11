//
//  UIKitExtensions.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/11/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation
//import ReactiveCocoa
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
        return UIColor(red: 44, green: 62, blue: 80, alpha: 1)
    }
    class func xoRed() -> UIColor {
        return UIColor(red: 228, green: 75, blue: 59, alpha: 1)
    }
    class func xoWhite() -> UIColor {
        return UIColor(red: 236, green: 240, blue: 241, alpha: 1)
    }
    class func xoLightBlue() -> UIColor {
        return UIColor(red: 52, green: 152, blue: 219, alpha: 1)
    }
    class func xoDarkBlue() -> UIColor {
        return UIColor(red: 41, green: 128, blue: 185, alpha: 1)
    }
}