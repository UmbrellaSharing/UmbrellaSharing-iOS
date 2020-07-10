//
//  QRCodeScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/09.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class QRCodeScreenViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UmbrellaButton!
    @IBOutlet weak var backButton: UmbrellaButton!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    override func viewDidLoad() {
        // TODO: We need to store qr code somewhere
        // TODO: We need to init qr code
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        continueButton.setTitle("Continue", for: .normal)
        backButton.setTitle("Go Back", for: .normal)
    }
    
    @IBAction func pressContinue(_ sender: Any) {
        // We can't just press - we need to check if the operation was sumbitted
        print("POC - pressed")
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
