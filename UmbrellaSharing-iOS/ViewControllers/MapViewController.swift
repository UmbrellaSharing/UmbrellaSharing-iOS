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
    
//    @IBOutlet weak var proceedButton: UmbrellaButton!
    
    
    @IBOutlet weak var proceedButton: UmbrellaButton!
    
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timeAndPriceLabel: MapCounterLabel!
    
    // TODO: Level 1 - Implement stopwatches with a price that changes
    // How to do stopwatches: https://www.youtube.com/watch?v=lx3EMAs924w
    
    var mapView: GMSMapView?
    var mapMode: UmbrellaUtil.MapMode?
    
    var orderInformation: OrderInformation?
    
    override func viewDidLoad() {
        print("POC init")
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        initButtons()
        initMap()
        initMarkers(mapView!)
        initCounter()
    }
    
    private func initCounter() {
        timeAndPriceLabel.isHidden = true
        if let mapMode = mapMode, mapMode == UmbrellaUtil.MapMode.rentalMode {
            timeAndPriceLabel.isHidden = false
        }
    }
    
    private func initMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 55.76, longitude: 37.62, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        if let mapView = mapView {
            self.view.addSubview(mapView)
            self.view.sendSubviewToBack(mapView)
        }
    }
    
    // TODO: Level 1 - Implement real data initialization
    private func initMarkers(_ mapView: GMSMapView) {
        let firstMarker = GMSMarker()
        firstMarker.position = CLLocationCoordinate2D(latitude: 55.76, longitude: 37.62)
        firstMarker.title = "First spot"
        firstMarker.snippet = "First spot"
        firstMarker.map = mapView
        
        let secondMarker = GMSMarker()
        secondMarker.position = CLLocationCoordinate2D(latitude: 55.79, longitude: 37.64)
        secondMarker.title = "Second Spot"
        secondMarker.snippet = "Second Spot"
        secondMarker.map = mapView
        
        let thirdMarker = GMSMarker()
        thirdMarker.position = CLLocationCoordinate2D(latitude: 55.71, longitude: 37.57)
        thirdMarker.title = "Third Spot"
        thirdMarker.snippet = "Third Spot"
        thirdMarker.map = mapView
    }
    
    private func initButtons() {
        if let mapMode = mapMode {
            switch mapMode {
            case .locationsMode:
                proceedButton.setTitle("Rent an Umbrella", for: .normal)
                proceedButton.setTitle("Back to Home", for: .normal)
            case .rentalMode:
                proceedButton.setTitle("Return an Umbrella", for: .normal)
                backButton.isHidden = true
            }
        }
    }
    
    @IBAction func `continue`(_ sender: Any) {
        if let mapMode = mapMode {
            switch mapMode {
            case .locationsMode:
                // TODO: Level 1 - Ask Ilya what shold be done in this case if we need actually to send a user for the next screen
                print("Locations Mode")
            case .rentalMode:
                openQRScreenToReturnUmbrella()
                print("Rental mode")
            }
        }
    }
    
    private func openQRScreenToReturnUmbrella() {
        // TODO: Level 2 - Think better about which kind of orderInformation we should pass here and what kind of QR should be generated there
        let storyBoard: UIStoryboard = UIStoryboard(name: "QRCodeScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRCodeScreenViewController") as! QRCodeScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        if let orderInformation = orderInformation {
            newViewController.orderInformation = orderInformation
        }
        newViewController.operationType = UmbrellaUtil.OperationType.returnUmbrella
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
