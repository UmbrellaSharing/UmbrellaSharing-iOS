//
//  UmbrellaButton.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/04.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

@IBDesignable
class UmbrellaButton: UIButton {
    
    // TODO: In layoutSubview - check the font size accordingly.
    let defaultButtonHeight: Int = 44
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
        
        if (Int(self.bounds.height) > defaultButtonHeight) {
            self.titleLabel?.font = self.titleLabel?.font.withSize(CGFloat(22))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
