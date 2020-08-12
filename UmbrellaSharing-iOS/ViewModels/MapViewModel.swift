//
//  MapViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/02.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class MapViewModel {

    weak var delegate: MapDataModelDelegate?
    
    func load() {
        loadLocations()
    }
    
    private func loadLocations() {
        NetworkManager.shared.getLocationPoints().done { [weak self] response in
            guard self != nil else { return }
            if let delegate = self?.delegate {
                delegate.didLoadLocations(locations: response)
            }
        }.catch { error in
            print("Error: \(error)")
        }
    }
}

protocol MapDataModelDelegate: class {
    func didLoadLocations(locations: [LocationPointEntity])
}
