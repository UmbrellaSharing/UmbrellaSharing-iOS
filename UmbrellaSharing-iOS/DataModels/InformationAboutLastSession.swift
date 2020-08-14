//
//  InformationAboutLastSession.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/12.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class InformationAboutLastSession: NSObject, NSCoding {
    
    // MARK: Properties
    
    var mapScreenIsOpenInRentalMode: Bool?
    var orderId: Int?
    
    // MARK: Types
    
    struct PropertyKey {
        static let mapScreenIsOpenInRentalMode = "mapScreenIsOpenInRentalMode"
        static let orderId = "orderId"
    }
    
    // MARK: Initialization
    
    init?(mapScreenIsOpenInRentalMode: Bool?, orderId: Int?) {
        self.mapScreenIsOpenInRentalMode = mapScreenIsOpenInRentalMode
        self.orderId = orderId
    }
    
    // TODO: Level 3 - Should we make this global? with all others data models?
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("informationAboutLastSession")
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(mapScreenIsOpenInRentalMode, forKey: PropertyKey.mapScreenIsOpenInRentalMode)
        coder.encode(orderId, forKey: PropertyKey.orderId)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let mapScreenIsOpenInRentalMode = aDecoder.decodeObject(forKey: PropertyKey.mapScreenIsOpenInRentalMode) as? Bool else {
            print("Unable to decode the mapScreenIsOpenInRentalMode.")
            return nil
        }
        
        guard let orderId = aDecoder.decodeObject(forKey: PropertyKey.orderId) as? Int else {
            print("Unable to decode the orderId.")
            return nil
        }
        
        self.init(mapScreenIsOpenInRentalMode: mapScreenIsOpenInRentalMode, orderId: orderId)
    }
}
