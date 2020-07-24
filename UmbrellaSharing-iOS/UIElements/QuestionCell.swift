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
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var arrowSign: UIImageView!
    
    private var isOpen: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setQuestionCell(_ questionText: String) {
        questionLabel.text = questionText
    }
    
    func changeTheState() {
        print("POC in change the state - state - \(isOpen)")
        self.isOpen = !self.isOpen
        if (self.isOpen) {
            print("POC in change the state - if true - \(isOpen)")
            arrowSign.image = UIImage(named: "arrowTop")
        } else {
            print("POC in change the state - if false - \(isOpen)")
            arrowSign.image = UIImage(named: "arrowDown")
        }
    }
}
