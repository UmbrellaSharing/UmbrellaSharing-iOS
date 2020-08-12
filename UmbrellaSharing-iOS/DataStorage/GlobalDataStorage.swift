//
//  GlobalDataStorage.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/12.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import PromiseKit

class GlobalDataStorage {
    
    static let shared = GlobalDataStorage()
    
    private init() { }
    
    // MARK: Global Objects
    
    private(set) var userCredentials: UserCredentials?
    
    // MARK: Public Methods
    
    func loadUserCredentials() {
        let userCredentialsFromStorage = loadUserCredentialsFromStorage()
        if let userCredentialsFromStorage = userCredentialsFromStorage {
            self.userCredentials = userCredentialsFromStorage
        } else {
            loadUserCredentialsFromServerAndSaveToStorage()
        }
    }
    
    // MARK: Private Methods
    
    private func loadUserCredentialsFromServerAndSaveToStorage() {
        NetworkManager.shared.getUserId().done { [weak self] response in
            guard self != nil else { return }
            self?.userCredentials = UserCredentials.init(userId: String(response.userId))
            self?.saveUserCredentialsToStorage()
        }.catch { error in
            print("Error: \(error)")
        }
    }
    
    private func saveUserCredentialsToStorage() {
        if let userCredentials = userCredentials {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: userCredentials, requiringSecureCoding: false)
                try data.write(to: UserCredentials.ArchiveURL)
                print("User credentials successfully saved.")
            } catch {
                print("Failed to save user credentials.")
            }
        }
    }
    
    private func loadUserCredentialsFromStorage() -> UserCredentials? {
        if let nsData = NSData(contentsOf: UserCredentials.ArchiveURL) {
            do {
                let data = Data(referencing: nsData)
                
                if let loadedUserCredentials = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserCredentials {
                    return loadedUserCredentials
                }
            } catch {
                print("Couldn't load user credentials.")
                return nil
            }
        }
        return nil
    }
}
