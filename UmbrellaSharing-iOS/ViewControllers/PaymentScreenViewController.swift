//
//  PaymentScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/08.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class PaymentScreenViewController: UIViewController {
    
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    // TODO: Make all needed func private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        continueButton.setTitle("Proceed to Payment", for: .normal)
        backButton.setTitle("Go Back", for: .normal)
    }
    
    
    @IBAction func PressContinue(_ sender: Any) {
          print("POC - payment")
      }
   
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
