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
    
    var operationType: UmbrellaUtil.OperationType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        continueButton.setTitle("Proceed to Payment", for: .normal)
        backButton.setTitle("Go Back", for: .normal)
    }
    
    @IBAction func pressContinue(_ sender: Any) {
        // TODO: Level 2 - Feature - Big - The Most Important. We need to do all payment checks. But We are waiting before Iliya make the Yandex Payments.
        openQRCodeScreen()
    }
    
    private func openQRCodeScreen() {
        if let operationType = operationType {
            let storyBoard: UIStoryboard = UIStoryboard(name: "QRCodeScreen", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRCodeScreenViewController") as! QRCodeScreenViewController
            newViewController.modalPresentationStyle = .fullScreen
            newViewController.operationType = operationType
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openInformation(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "InformationScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InformationScreenViewController") as! InformationScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}
