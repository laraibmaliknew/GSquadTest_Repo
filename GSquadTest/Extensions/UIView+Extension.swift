//
//  UIView+Extension.swift
//
//  GSquadTest
//
//  Created by Apple on 11/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    // Shadow
    @IBInspectable var shadoow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0), shadowOpacity: Float = 0.35, shadowRadius: CGFloat = 5.0) {
        let layer = self.layer
        layer.masksToBounds = false
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let backgroundColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundColor
        
    }
    
    
    // Corner radius
    @IBInspectable var circle: Bool {
        get {
            return layer.cornerRadius == self.bounds.width*0.5
        }
        set {
            if newValue == true {
                self.cornrRadius = self.bounds.width*0.5
            }
        }
    }
    
    @IBInspectable var cornrRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var BottomRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            roundCorners(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: newValue)
        }
    }
    
    @IBInspectable var TopRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            roundCorners(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: newValue)
        }
    }
    
    
    @IBInspectable var TopRightcornrRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            roundCorners(with: [.layerMinXMinYCorner], radius: newValue)
            
        }
    }
    
    @IBInspectable var TopLeftcornrRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            roundCorners(with: [.layerMaxXMinYCorner], radius: newValue)
            
        }
    }
    
    @IBInspectable var BottomRightcornrRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            roundCorners(with: [.layerMinXMaxYCorner], radius: newValue)
            
        }
    }
    
    @IBInspectable var BottomLeftcornrRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            roundCorners(with: [.layerMaxXMaxYCorner], radius: newValue)
        }
    }
    
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }

    // Borders
    // Border width
    @IBInspectable
    public var bordrWidthForAll: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    // Border color
    @IBInspectable
    public var bordrColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
    }
    
    
    @IBInspectable
    public var topbordrWidth: CGFloat {
        set {
            addTopBorder(with: bordrColor, andWidth: newValue)
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    public var leftbordrWidth: CGFloat {
        set {
            addLeftBorder(with: bordrColor, andWidth: newValue)
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    public var rightbordrWidth: CGFloat {
        set {
            addRightBorder(with: bordrColor, andWidth: newValue)
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    public var bottombordrWidth: CGFloat {
        set {
            addBottomBorder(with: bordrColor, andWidth: newValue)
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
}



extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}



///--------------------------------------------------------------------------------------

// MARK: - Gradient

public enum CAGradientPoint {
    case topLeft
    case centerLeft
    case bottomLeft
    case topCenter
    case center
    case bottomCenter
    case topRight
    case centerRight
    case bottomRight
    var point: CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .centerLeft:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeft:
            return CGPoint(x: 0, y: 1.0)
        case .topCenter:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottomCenter:
            return CGPoint(x: 0.5, y: 1.0)
        case .topRight:
            return CGPoint(x: 1.0, y: 0.0)
        case .centerRight:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}

extension CAGradientLayer {
    
    convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.frame.origin = CGPoint.zero
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}



@IBDesignable
extension UIView {
    func layerGradient(startPoint:CAGradientPoint, endPoint:CAGradientPoint ,colorArray:[CGColor], type:CAGradientLayerType ) {
        let gradient = CAGradientLayer(start: .topLeft, end: .topRight, colors: colorArray, type: type)
        gradient.frame.size = self.frame.size
        self.layer.insertSublayer(gradient, at: 0)
    }
}
