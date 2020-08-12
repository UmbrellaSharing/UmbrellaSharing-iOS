//
//  DataStorage.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/12.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class UserCredentials: NSObject, NSCoding {

    // MARK: Properties
    
    var userId: String?
    
    // MARK: Types
    
    struct PropertyKey {
        static let userId = "userId"
    }
    
    // MARK: Initialization
    init?(userId: String?) {
        self.userId = userId
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("userSessionInformation")
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(userId, forKey: PropertyKey.userId)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let userId = aDecoder.decodeObject(forKey: PropertyKey.userId) as? String else {
            print("Unable to decode the userId for a User Object")
            return nil
        }
        self.init(userId: userId)
    }
    
}

