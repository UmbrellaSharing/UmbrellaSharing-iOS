//
//  ViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/05/22.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkInternetConnectionAndProceedIfPossible()
    }
    
    // MARK: Private methods
    
    private func checkInternetConnectionAndProceedIfPossible() {
        NetworkManager.shared.checkInternet(flag: false, completionHandler: { (isConnectionStable: Bool) -> Void in
            if (!isConnectionStable) {
                self.presentErrorMessage()
            }
            self.moveUserToAppropriateStageIfNeeded()
        })
    }
    
    private func presentErrorMessage() {
        let noInternetConnectionError = UIAlertController(title: "Oops, there is a problem!",
                                                          message: "Sorry, there is no internet connection right now. You cannot use our application without stable internet connection. Please, try later.",
                                                          preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        noInternetConnectionError.addAction(okAction)
        self.present(noInternetConnectionError, animated: true, completion: nil)
    }
    
    private func moveUserToAppropriateStageIfNeeded() {
        let applicationCheckpoint = GlobalDataStorage.shared.informationAboutLastSession?.applicationCheckpoint
        switch applicationCheckpoint {
        case .afterSuccessfulPayment:
            openQRScreen()
        case .rentalModeStarted:
            openMapScreen()
        default:
            break // Do nothing
        }
    }
    
    private func openMapScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mapMode = UmbrellaUtil.MapMode.rentalMode
        
        let userCredentials = GlobalDataStorage.shared.userCredentials
        let orderId = GlobalDataStorage.shared.informationAboutLastSession?.orderId
        let orderInformation = OrderInformation(userId: userCredentials?.userId, orderId: orderId, code: nil)
        newViewController.orderInformation = orderInformation
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func openQRScreen() {
        let operationType = GlobalDataStorage.shared.informationAboutLastSession?.operationType
        if let operationType = operationType {
            let storyBoard: UIStoryboard = UIStoryboard(name: "QRCodeScreen", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRCodeScreenViewController") as! QRCodeScreenViewController
            newViewController.modalPresentationStyle = .fullScreen
            newViewController.operationType = operationType
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    
    private func openPaymentScreen(_ operationType: UmbrellaUtil.OperationType) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PaymentScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentScreenViewController") as! PaymentScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.operationType = operationType
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // MARK: IB Actions
    
    @IBAction func rentUmbrella(_ sender: Any) {
        openPaymentScreen(UmbrellaUtil.OperationType.rentUmbrella)
    }
    
    @IBAction func buyUmbrella(_ sender: Any) {
        openPaymentScreen(UmbrellaUtil.OperationType.buyUmbrella)
    }
    
    @IBAction func checkLocations(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mapMode = UmbrellaUtil.MapMode.locationsMode
        self.present(newViewController, animated: true, completion: nil)
    }

    @IBAction func openInformation(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "InformationScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InformationScreenViewController") as! InformationScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}
