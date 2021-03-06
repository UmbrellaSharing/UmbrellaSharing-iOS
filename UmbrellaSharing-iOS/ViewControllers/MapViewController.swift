//
//  MapViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/06/10.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps

class MapViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var proceedButton: UmbrellaButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mapInformationSectionLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var clockIcon: UIImageView!
    
    // MARK: - Public
    
    var timer: Timer?
    var counter = 0.0
    
    var mapView: GMSMapView?
    var mapMode: UmbrellaUtil.MapMode?
    var presentedMaximumPriceReachedFlag: Bool = false
    
    var orderInformation: OrderInformation?
    
    // MARK: - Private
    
    private let mapViewModel = MapViewModel()
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: - Private Methods
    
    private func initView() {
        initCounter()
        initPanel()
        loadLocations()
        initButtons()
        initMap()
    }
    
    private func loadLocations() {
        mapViewModel.delegate = self
        self.view.makeToastActivity(.center)
        mapViewModel.load()
    }
    
    private func initCounter() {
        if mapMode == UmbrellaUtil.MapMode.rentalMode {
            mapInformationSectionLabel.text = "00:00 0₽ "
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
            updateCounterIfDateCashed()
        } else {
            mapInformationSectionLabel.text = "Точки Выдачи"
        }
    }
    
    private func initPanel() {
        if mapMode == UmbrellaUtil.MapMode.rentalMode {
            clockIcon.isHidden = false
        } else {
            clockIcon.isHidden = true
        }
    }
    
    private func updateCounterIfDateCashed() {
        let cashedDate = mapViewModel.getCashedDate()
        if let cashedDate = cashedDate {
            updateCounter(cashedDate)
        }
    }
    
    private func updateCounter(_ cashedDate: Date) {
        let currentDate = UmbrellaUtil.generateCurrentDateInGMT3Format()
        if let currentDate = currentDate {
            let differenceInSecondsBetweenNowAndCashedDate = currentDate.timeIntervalSince(cashedDate)
            self.counter = differenceInSecondsBetweenNowAndCashedDate
        }
    }
    
    @objc private func updateTimerLabel() {
        counter += 1
        let textForTimeAndPriceButton = mapViewModel.prepareTextForTimeAndPriceButton(counter)
        mapInformationSectionLabel.text = textForTimeAndPriceButton
    }
    
    private func presentMessageOnBuyingUmbrella() {
        let messageOnBuyingUmbrella = UIAlertController(title: "Вы купили зонт!",
                                                          message: "Спасибо за покупку. Пожалуйста, оставьте отзыв.",
                                                          preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            // We should make payment transaction here
            GlobalDataStorage.shared.cleanInformationAboutLastSession()
            self.openFeedbackScreen()
        }
        messageOnBuyingUmbrella.addAction(okAction)
        self.present(messageOnBuyingUmbrella, animated: true, completion: nil)
    }
    
    private func presentMessageNotToReturnUmbrella() {
        let messageOfNotReturningItem = UIAlertController(title: "Спасибо!",
                                                          message: "Вы больше не должны возвращать зонт, так как вы уже заплатите за аренду сумму равную покупке зонта.",
                                                          preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            // We should make payment transaction here
            GlobalDataStorage.shared.cleanInformationAboutLastSession()
            self.openHomeScreen()
        }
        messageOfNotReturningItem.addAction(okAction)
        self.present(messageOfNotReturningItem, animated: true, completion: nil)
    }
    
    private func initMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 55.76, longitude: 37.62, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        if let mapView = mapView {
            self.view.addSubview(mapView)
            self.view.sendSubviewToBack(mapView)
        }
    }
    
    private func initMarkers(_ mapView: GMSMapView, _ locations: [LocationPointEntity]) {
        for location in locations {
            let currentMarker = GMSMarker()
            currentMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            currentMarker.title = location.name
            currentMarker.snippet = location.description
            currentMarker.map = mapView
        }
    }
    
    private func initButtons() {
        if let mapMode = mapMode {
            switch mapMode {
            case .locationsMode:
                proceedButton.setTitle("Арендовать Зонт", for: .normal)
                backButton.setTitle("Вернуться", for: .normal)
            case .rentalMode:
                addBuyButton()
                proceedButton.setTitle("Вернуть Зонт", for: .normal)
                backButton.isHidden = true
            }
        }
    }
    
    private func addBuyButton() {
        let buyButton = UmbrellaButton()
        
        buyButton.setTitle("Купить Зонт", for: .normal)
        buyButton.backgroundColor = UmbrellaUtil.getUIColor(hex: "#3185BC")
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyButton.setTitleColor(UmbrellaUtil.getUIColor(hex: "#0092D1"), for: .highlighted)
        buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        buyButton.addTarget(self, action: #selector(buyUmbrella), for: .touchUpInside)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(buyButton)
    }
    
    private func openHomeScreen() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func openFeedbackScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "FeedbackScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackScreenViewController") as! FeedbackScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func openPaymentScreenToRentUmbrella() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PaymentScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentScreenViewController") as! PaymentScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.operationType = UmbrellaUtil.OperationType.rentUmbrella
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func openQRScreenToReturnUmbrella() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "QRCodeScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRCodeScreenViewController") as! QRCodeScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        if let orderInformation = orderInformation {
            newViewController.orderInformation = orderInformation
        }
        newViewController.operationType = UmbrellaUtil.OperationType.returnUmbrella
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // MARK: - IB Actions
    
    @IBAction func `continue`(_ sender: Any) {
        if let mapMode = mapMode {
            switch mapMode {
            case .locationsMode:
                openPaymentScreenToRentUmbrella()
            case .rentalMode:
                openQRScreenToReturnUmbrella()
            }
        }
    }
    
    @objc func buyUmbrella(sender: UIButton!) {
           presentMessageOnBuyingUmbrella()
       }
    
    @IBAction func openInformation(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "InformationScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "InformationScreenViewController") as! InformationScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MapViewController: MapDataModelDelegate {
    func didLoadLocations(locations: [LocationPointEntity]) {
        self.view.hideToastActivity()
        initMarkers(mapView!, locations)
    }
    
    func didReachTheMaximumPrice() {
        if (!presentedMaximumPriceReachedFlag) {
            presentedMaximumPriceReachedFlag = true
            presentMessageNotToReturnUmbrella()
        }
    }
}
