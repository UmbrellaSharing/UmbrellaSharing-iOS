//
//  UmbrellaButton.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/04.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit


class UmbrellaButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.backgroundColor = UIColor.white.cgColor
    }
}
