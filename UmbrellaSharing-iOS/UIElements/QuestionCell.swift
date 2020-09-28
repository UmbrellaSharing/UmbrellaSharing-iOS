//
//  QuestionCell.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/20.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class QuestionCell: UITableViewCell {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var arrowSign: UIImageView!
    
    // MARK: - Private Variables
    private var isOpen: Bool = false
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods
    
    func setQuestionCell(_ questionText: String) {
        questionLabel.text = questionText
    }
    
    func changeTheState() {
        self.isOpen = !self.isOpen
        if (self.isOpen) {
            arrowSign.image = UIImage(named: "minusSign")
        } else {
            arrowSign.image = UIImage(named: "plusSign")
        }
    }
}
