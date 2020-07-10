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
    
    
  
    @IBAction func pressContinue(_ sender: Any) {
        print("POC pressed Continue")
        // TODO: First we need to check all payments and if everthing is fine move to another screen
        openQRCodeScreen()
    }
    
    private func openQRCodeScreen() {
        print("POC pressed Continue - 1")
        let storyBoard: UIStoryboard = UIStoryboard(name: "QRCodeScreen", bundle: nil)
        print("POC pressed Continue -2 ")
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRCodeScreenViewController") as! QRCodeScreenViewController
        print("POC pressed Continue - 3")
        newViewController.modalPresentationStyle = .fullScreen
        print("POC pressed Continue - 4")
        self.present(newViewController, animated: true, completion: nil)
        print("POC pressed Continue - 5")
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
