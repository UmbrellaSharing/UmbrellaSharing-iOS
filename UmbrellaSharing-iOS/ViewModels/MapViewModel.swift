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
    
    func prepareTextForTimeAndPriceButton(_ counter: Double) -> String {
        let hours = normilizeTimeValue(Int(counter) / 3600)
        let minutes = normilizeTimeValue(Int(counter) / 60 % 60)
        let seconds = normilizeTimeValue(Int(counter) % 60)
        var timeString = "00:00"
        if (Int(hours) == 0) {
            timeString = "\(minutes):\(seconds)"
        } else {
            timeString = "\(hours):\(minutes):\(seconds)"
        }
        
        let priceString = "\(calculatePrice(from: counter))₽"
        return timeString + " " + priceString
    }
    
    private func normilizeTimeValue(_ rawTimeValue: Int) -> String {
        if rawTimeValue < 10 {
            let result = "0" + String(rawTimeValue)
            return result
        }
        return String(rawTimeValue)
    }
    
    func calculatePrice(from counter: Double) -> Int {
        
        // Constants
        let secondsInHour = 60 * 60
        let secondsInDay = 24 * secondsInHour
        
        var price: Int = 0
        let roundCounter = Int(counter)
        
        if roundCounter <= secondsInHour {
            price = 50
        } else if roundCounter > secondsInHour && roundCounter < secondsInDay {
            price = 100
        } else {
            price = 300
            delegate?.didReachTheMaximumPrice()
        }
        
        return price
    }
    
    func getCashedDate() -> Date? {
        let informationAboutLastSession = GlobalDataStorage.shared.informationAboutLastSession
        if informationAboutLastSession?.applicationCheckpoint == ApplicationImportantCheckpoint.rentalModeStarted {
            return GlobalDataStorage.shared.informationAboutLastSession?.rentStartDate
        }
        return nil
    }
}

protocol MapDataModelDelegate: class {
    func didLoadLocations(locations: [LocationPointEntity])
    
    func didReachTheMaximumPrice()
}
