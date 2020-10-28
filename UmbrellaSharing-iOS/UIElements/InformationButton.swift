//
//  InformationButton.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/18.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

@IBDesignable
class InformationButton: UIButton {
    
    // MARK: - Private Variables
    
    private var iconName: String = "informationSign"
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Inspectable Variables
    
    @IBInspectable var useDarkSign: Bool = false {
        didSet {
           iconName =  useDarkSign ? "informationSignMap" : "informationSign"
            setupButton()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupButton() {
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let informationSign = UIImage(named: iconName, in: bundle, compatibleWith: self.traitCollection)
        self.setImage(informationSign, for: .normal)
        
        // Add constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
}
