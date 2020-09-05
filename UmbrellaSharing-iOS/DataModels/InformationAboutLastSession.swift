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
    var operationType: UmbrellaUtil.OperationType?
    
    // MARK: - Types
    
    struct PropertyKey {
        static let applicationCheckpoint = "applicationCheckpoint"
        static let orderId = "orderId"
        static let rentStartDate = "rentStartDate"
        static let operationType = "operationType"
    }
    
    // MARK: - Initialization
    
    init?(applicationCheckpoint: ApplicationImportantCheckpoint?, orderId: Int?, rentStartDate: Date?, operationType: UmbrellaUtil.OperationType?) {
        self.applicationCheckpoint = applicationCheckpoint
        self.orderId = orderId
        self.rentStartDate = rentStartDate
        self.operationType = operationType
    }
    
    init(applicationCheckpoint: ApplicationImportantCheckpoint?, orderId: Int?, rentStartDate: Date?) {
           self.applicationCheckpoint = applicationCheckpoint
           self.orderId = orderId
           self.rentStartDate = rentStartDate
       }
    
    init(applicationCheckpoint: ApplicationImportantCheckpoint?, operationType: UmbrellaUtil.OperationType?) {
        self.applicationCheckpoint = applicationCheckpoint
        self.operationType = operationType
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(applicationCheckpoint?.rawValue, forKey: PropertyKey.applicationCheckpoint)
        coder.encode(orderId, forKey: PropertyKey.orderId)
        coder.encode(rentStartDate, forKey: PropertyKey.rentStartDate)
        coder.encode(operationType?.rawValue, forKey: PropertyKey.operationType)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let applicationCheckpointRawValue = aDecoder.decodeObject(forKey: PropertyKey.applicationCheckpoint) as? Int else {
            print("Unable to decode the applicationImportantCheckpoint.")
            return nil
        }
        
        let orderId = aDecoder.decodeObject(forKey: PropertyKey.orderId) as? Int
        let rentStartDate = aDecoder.decodeObject(forKey: PropertyKey.rentStartDate) as? Date
        let operationTypeRawValue = aDecoder.decodeObject(forKey: PropertyKey.operationType) as? Int
        
        let applicationCheckpoint = ApplicationImportantCheckpoint(rawValue: applicationCheckpointRawValue)
        
        var operationType: UmbrellaUtil.OperationType? = nil
        if let operationTypeRawValue = operationTypeRawValue {
            operationType = UmbrellaUtil.OperationType(rawValue: operationTypeRawValue)
        }
        
        self.init(applicationCheckpoint: applicationCheckpoint, orderId: orderId, rentStartDate: rentStartDate, operationType: operationType)
    }
}

enum ApplicationImportantCheckpoint: Int, Codable {
    case afterSuccessfulPayment
    case rentalModeStarted
}
