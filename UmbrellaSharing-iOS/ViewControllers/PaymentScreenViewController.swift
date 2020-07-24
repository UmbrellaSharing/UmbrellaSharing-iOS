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
    
    private let paymentViewModel = PaymentViewModel()
    var operationType: UmbrellaUtil.OperationType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentViewModel.load()
        initView()
    }
    
    private func initView() {
        continueButton.setTitle("Proceed to Payment", for: .normal)
        backButton.setTitle("Go Back", for: .normal)
    }
    
    @IBAction func pressContinue(_ sender: Any) {
        // TODO: Level 1 - First we need to check all payments and if everthing is fine move to another screen
        openQRCodeScreen()
    }
    
    private func openQRCodeScreen() {
        if let operationType = operationType {
            let storyBoard: UIStoryboard = UIStoryboard(name: "QRCodeScreen", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRCodeScreenViewController") as! QRCodeScreenViewController
            newViewController.modalPresentationStyle = .fullScreen
            newViewController.orderInformation = paymentViewModel.orderInformatoin
            newViewController.operationType = operationType
            self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
