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
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        UIView.self.setAnimationsEnabled(false)
    }
}
