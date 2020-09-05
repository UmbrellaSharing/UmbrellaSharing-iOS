//
//  InformationAboutLastSession.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/12.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class InformationAboutLastSession: NSObject, NSCoding {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
       static let ArchiveURL = DocumentsDirectory.appendingPathComponent("informationAboutLastSession")
    
    // MARK: - Properties
    
    var applicationCheckpoint: ApplicationImportantCheckpoint?
    var orderId: Int?
    var rentStartDate: Date?
    
    // MARK: - Types
    
    struct PropertyKey {
        static let applicationCheckpoint = "applicationCheckpoint"
        static let orderId = "orderId"
        static let rentStartDate = "rentStartDate"
    }
    
    // MARK: - Initialization
    
    init?(applicationCheckpoint: ApplicationImportantCheckpoint?, orderId: Int?, rentStartDate: Date?) {
        self.applicationCheckpoint = applicationCheckpoint
        self.orderId = orderId
        self.rentStartDate = rentStartDate
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(applicationCheckpoint?.rawValue, forKey: PropertyKey.applicationCheckpoint)
        coder.encode(orderId, forKey: PropertyKey.orderId)
        coder.encode(rentStartDate, forKey: PropertyKey.rentStartDate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let applicationCheckpointRawValue = aDecoder.decodeObject(forKey: PropertyKey.applicationCheckpoint) as? Int else {
            print("Unable to decode the applicationImportantCheckpoint.")
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
        
        let applicationCheckpoint = ApplicationImportantCheckpoint(rawValue: applicationCheckpointRawValue)
        self.init(applicationCheckpoint: applicationCheckpoint, orderId: orderId, rentStartDate: rentStartDate)
    }
}

enum ApplicationImportantCheckpoint: Int, Codable {
    case afterSuccessfulPayment
    case rentalModeStarted
}
