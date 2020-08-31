//
//  InformationButton.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/18.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

@IBDesignable class InformationButton: UIButton {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: Private Methods
    
    private func setupButton() {
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let informationSign = UIImage(named: "informationSign", in: bundle, compatibleWith: self.traitCollection)
        
        // TODO: Level 4 - As an addition - we can put the same sign with different color to make small animation here
        self.setImage(informationSign, for: .normal)
        
        // Add constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        self.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}
