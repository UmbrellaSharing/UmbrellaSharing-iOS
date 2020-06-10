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
    
    
    @IBOutlet weak var rentButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        initButtons()
        initMap()
        initMarkers(mapView!)
    }
    
    private func initMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 55.76, longitude: 37.62, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        if let mapView = mapView {
            self.view.addSubview(mapView)
            self.view.sendSubviewToBack(mapView)
        }
    }
    
    // TODO: Implement real data initialization
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
        rentButton.setTitle("Rent an Umbrella", for: .normal)
        backButton.setTitle("Back to Home", for: .normal)
        
        rentButton.layer.cornerRadius = 20
        rentButton.layer.borderWidth = 1
        rentButton.layer.borderColor = UIColor.black.cgColor
        rentButton.layer.backgroundColor = UIColor.white.cgColor
        
        backButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.backgroundColor = UIColor.white.cgColor
        
     }
    
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}