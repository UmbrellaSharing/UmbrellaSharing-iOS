//
//  QRCodeScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/09.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class QRCodeScreenViewController: UIViewController, QRDataModelDelegate {

    @IBOutlet weak var continueButton: UmbrellaButton!
    @IBOutlet weak var backButton: UmbrellaButton!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    let qrViewModel = QRViewModel()
    
    var operationType: UmbrellaUtil.OperationType?
    var orderInformation: OrderInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        continueButton.setTitle("Continue", for: .normal)
        backButton.setTitle("Go Back", for: .normal)
        presentQR()
    }
    
    private func presentQR() {
        if let orderInformation = orderInformation, let orderId = orderInformation.orderId {
            // Generating QR Code if user's returning an umbrella
            if let operationType = operationType, operationType == UmbrellaUtil.OperationType.returnUmbrella {
                qrViewModel.delegate = self
                qrViewModel.getReturnCode(orderId: orderId)
            } else {
                // Generating QR if user's taking an umbrella
                if let code = orderInformation.code {
                    qrCodeImageView.image = generateQRCode(from: String(code))
                }
            }
        }
    }
    
    @IBAction func pressContinue(_ sender: Any) {
        // TODO: Level 1 - Show the notification that QR need to be scanned
        
        if let orderInformation = orderInformation, let orderId = orderInformation.orderId, let operationType = operationType {
            if (qrViewModel.canWeProceed(orderId: orderId, qrType: operationType)) {
                switch operationType {
                case .buyUmbrella:
                    openHomeScreen()
                case.rentUmbrella:
                    openMapScreen()
                case.returnUmbrella:
                    // TODO: Level 2 - Here should be some check
                    
                    // If everything is okay and we are ready to move to the feedback screen,
                    // then right before that we need to inform that rental mode is over, and we don't need to open
                    // map screen if application is closed later on
                    GlobalDataStorage.shared.cleanInformationAboutLastSession()
                    
                    openFeedbackScreen()
                }
            } else {
                // Write this code here - we can't proceed
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: Level 2 - Understand what does it mean
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    private func openHomeScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func openMapScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mapMode = UmbrellaUtil.MapMode.rentalMode
        newViewController.orderInformation = orderInformation
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func openFeedbackScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "FeedbackScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackScreenViewController") as! FeedbackScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func didLoadReturnCode(code: Int) {
        qrCodeImageView.image = generateQRCode(from: String(code))
    }
}
