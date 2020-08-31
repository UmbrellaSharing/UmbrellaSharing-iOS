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
    
    // TODO: Level 2 - Change the information logic on this screen. On tap open the info screen.
    // But on tap of price something, open the modal dialogue with prices
    
    // MARK: Outlets
    
    @IBOutlet weak var proceedButton: UmbrellaButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timeAndPriceLabel: MapCounterLabel!
    
    // MARK: Public
    
    var timer: Timer?
    var counter = 0.0
    
    var mapView: GMSMapView?
    var mapMode: UmbrellaUtil.MapMode?
    
    var orderInformation: OrderInformation?
    
    // MARK: Private
    
    private let mapViewModel = MapViewModel()
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: Private Methods
    
    private func initView() {
        loadLocations()
        initButtons()
        initMap()
        initCounter()
    }
    
    private func loadLocations() {
        mapViewModel.delegate = self
        self.view.makeToastActivity(.center)
        mapViewModel.load()
    }
    
    private func initCounter() {
        timeAndPriceLabel.isHidden = true
        if mapMode == UmbrellaUtil.MapMode.rentalMode {
            timeAndPriceLabel.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
            updateCounterIfDateCashed()
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
        timeAndPriceLabel.text = mapViewModel.prepareTextForTimeAndPriceLabel(counter)
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
                proceedButton.setTitle("Rent an Umbrella", for: .normal)
                backButton.setTitle("Back to Home", for: .normal)
            case .rentalMode:
                proceedButton.setTitle("Return an Umbrella", for: .normal)
                backButton.isHidden = true
            }
        }
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
    
    // MARK: IB Actions
    
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
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MapViewController: MapDataModelDelegate {
    func didLoadLocations(locations: [LocationPointEntity]) {
        self.view.hideToastActivity()
        initMarkers(mapView!, locations)
    }
}
