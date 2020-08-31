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
        checkIfAppWasClosedDuringRentalMode()
    }
    
    // MARK: Private methods
    
    private func checkIfAppWasClosedDuringRentalMode() {
        let informationAboutLastSession = GlobalDataStorage.shared.informationAboutLastSession
        if informationAboutLastSession?.hasRentStarted == true {
            openMapScreen()
        }
    }
    
    private func openMapScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mapMode = UmbrellaUtil.MapMode.rentalMode
        
        let userCredentials = GlobalDataStorage.shared.userCredentials
        let orderId = GlobalDataStorage.shared.informationAboutLastSession?.orderId
        // TODO: Level 3 - Think should we pass orderId and code or not? I think we don't need, but need to be checked
        let orderInformation = OrderInformation(userId: userCredentials?.userId, orderId: orderId, code: nil)
        newViewController.orderInformation = orderInformation
        self.present(newViewController, animated: true, completion: nil)
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
