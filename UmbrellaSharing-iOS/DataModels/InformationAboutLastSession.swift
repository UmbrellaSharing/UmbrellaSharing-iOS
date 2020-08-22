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
    
    var hasRentStarted: Bool?
    var orderId: Int?
    var rentStartDate: Date?
    
    // MARK: Types
    
    struct PropertyKey {
        static let hasRentStarted = "hasRentStarted"
        static let orderId = "orderId"
        static let rentStartDate = "rentStartDate"
    }
    
    // MARK: Initialization
    
    init?(hasRentStarted: Bool?, orderId: Int?, rentStartDate: Date?) {
        self.hasRentStarted = hasRentStarted
        self.orderId = orderId
        self.rentStartDate = rentStartDate
    }
    
    // TODO: Level 3 - Should we make this global? with all others data models?
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("informationAboutLastSession")
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(hasRentStarted, forKey: PropertyKey.hasRentStarted)
        coder.encode(orderId, forKey: PropertyKey.orderId)
        coder.encode(rentStartDate, forKey: PropertyKey.rentStartDate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let hasRentStarted = aDecoder.decodeObject(forKey: PropertyKey.hasRentStarted) as? Bool else {
            print("Unable to decode the hasRentStarted.")
            return nil
        }
        
        guard let orderId = aDecoder.decodeObject(forKey: PropertyKey.orderId) as? Int else {
            print("Unable to decode the orderId.")
            return nil
        }
        
        guard let rentStartDate = aDecoder.decodeObject(forKey: PropertyKey.rentStartDate) as? Date else {
            print("Unable to decode rentStartDate")
            return nil
        }
        
        self.init(hasRentStarted: hasRentStarted, orderId: orderId, rentStartDate: rentStartDate)
    }
}
