//
//  QRCodeScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/09.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

class QRCodeScreenViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    // MARK: Public
    
    var operationType: UmbrellaUtil.OperationType?
    var orderInformation: OrderInformation = OrderInformation()
    
    // MARK: Private
    private let qrViewModel = QRViewModel()
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrViewModel.delegate = self
        presentQR()
    }
    
    // MARK: Private methods
    
    private func presentQR() {
        self.view.makeToastActivity(.center)
        // Generating QR Code if user's returning an umbrella
        if operationType == UmbrellaUtil.OperationType.returnUmbrella {
            if let orderId = GlobalDataStorage.shared.informationAboutLastSession?.orderId {
                qrViewModel.getReturnQRCode(orderId: orderId)
            }
        } else {
            let userCredentials = GlobalDataStorage.shared.userCredentials
            let isBuy = operationType == UmbrellaUtil.OperationType.buyUmbrella
            if let userId = userCredentials?.userId {
                qrViewModel.getQRCode(userId: userId, isBuy: isBuy)
            }
        }
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
    
    private func rememberThatRentHasBeenStarted(orderId: Int, rentStartDate: Date) {
        let informationAboutLastSession = InformationAboutLastSession(hasRentStarted: true, orderId: orderId, rentStartDate: rentStartDate)
        if let informationAboutLastSession = informationAboutLastSession {
            GlobalDataStorage.shared.saveInformationAboutLastSession(informationAboutLastSession)
        }
    }
    
    // MARK: IB Actions
    
    @IBAction func pressContinue(_ sender: Any) {
        if let orderId = orderInformation.orderId, let operationType = operationType {
            if let code = orderInformation.code {
                // TODO: Level 5 - Remove after complete implementation
                // Insert this request in postman:
                print("https://us.2ssupport.ru/order/getOrderInfo?orderId=\(orderId)&code=\(code)&qrType=\(operationType.rawValue)")
            }
            qrViewModel.canWeProceed(orderId: orderId, qrType: operationType)
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

extension QRCodeScreenViewController: QRDataModelDelegate {
    func didLoadQRCode(orderId: Int, code: Int) {
        self.view.hideToastActivity()
        orderInformation.orderId = orderId
        orderInformation.code = code
        qrCodeImageView.image = qrViewModel.generateQRCode(from: String(code))
    }
    
    func didLoadReturnCode(code: Int) {
        self.view.hideToastActivity()
        self.orderInformation.code = code
        qrCodeImageView.image = qrViewModel.generateQRCode(from: String(code))
    }
    
    func qrCodeHasBeenScanned(startTime: Date) {
        switch operationType {
        case .buyUmbrella:
            openHomeScreen()
        case.rentUmbrella:
            // Write it in the local storage
            if let orderId = orderInformation.orderId {
                rememberThatRentHasBeenStarted(orderId: orderId, rentStartDate: startTime)
            }
            openMapScreen()
        case.returnUmbrella:
            // If everything is okay and we are ready to move to the feedback screen,
            // then right before that we need to inform that rental mode is over, and we don't need to open
            // map screen if application is closed later on
            let orderId = GlobalDataStorage.shared.informationAboutLastSession?.orderId
            let updatedInformationAboutLastSession = InformationAboutLastSession(hasRentStarted: false, orderId: orderId, rentStartDate: nil)
            GlobalDataStorage.shared.saveInformationAboutLastSession(updatedInformationAboutLastSession!)
            openFeedbackScreen()
        case .none:
            print("This case should never be launched.")
        }
    }
    
    func qrCodeHasNotBeenScanned() {
        self.view.makeToast("The operator must scan the code first", duration: 2.0, position: .bottom)
    }
    
}
