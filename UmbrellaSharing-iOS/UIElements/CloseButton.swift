//
//  CloseButton.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/24.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class CloseButton: UIButton {
    
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
        let informationSign = UIImage(named: "closeSign", in: bundle, compatibleWith: self.traitCollection)
        
        // TODO: Idea for the future - we can put the same sign with different color to make small animation here
        self.setImage(informationSign, for: .normal)
        
        // Add constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
}
