//
//  UIViewExtension.swift
//  MobileTest
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {

    @IBInspectable open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable open var borderColor: UIColor? {
        get { return (layer.borderColor != nil) ? UIColor(cgColor: layer.borderColor!) : nil }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            if (newValue < 1) {
                layer.cornerRadius = newValue * bounds.width
            } else {
                layer.cornerRadius = newValue
            }
        }
    }

    @IBInspectable open var shadowColor: UIColor? {
        get { return (layer.shadowColor != nil) ? UIColor(cgColor: layer.shadowColor!) : nil }
        set { layer.shadowColor = newValue?.cgColor }
    }

    @IBInspectable open var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable open var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

}