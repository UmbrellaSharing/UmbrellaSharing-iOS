//
//  FeedbackTextView.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/09/26.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class FeedbackTextView: UITextView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = .clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
    }
}
