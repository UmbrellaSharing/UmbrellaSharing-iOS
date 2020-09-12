//
//  UmbrellaLayoutView.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/09/12.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

@IBDesignable
class UmbrellaLayoutView: UIView {
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            self.layer.mask = rectShape
        }
    }
}
