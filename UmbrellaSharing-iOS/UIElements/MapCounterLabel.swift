//
//  MapCounter.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/15.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

class MapCounterLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    private func setupLabel() {
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = UIColor.black.cgColor
        layer.borderColor = UIColor.black.cgColor
    }
}
