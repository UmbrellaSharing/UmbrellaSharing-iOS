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
    private(set) var informationAboutLastSession: InformationAboutLastSession?
    
    // MARK: Public Methods
    
    func loadUserCredentials() {
        let userCredentialsFromStorage = loadUserCredentialsFromStorage()
        if let userCredentialsFromStorage = userCredentialsFromStorage {
            self.userCredentials = userCredentialsFromStorage
        } else {
            loadUserCredentialsFromServerAndSaveToStorage()
        }
    }
    
    func loadInformationAboutLastSession() {
        let informationAboutLastSession = loadInformationAboutLastSessionFromStorage()
        if let informationAboutLastSession = informationAboutLastSession {
            self.informationAboutLastSession = informationAboutLastSession
        }
    }
    
    public func saveInformationAboutLastSession(_ informationAboutLastSession: InformationAboutLastSession) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: informationAboutLastSession, requiringSecureCoding: false)
            try data.write(to: InformationAboutLastSession.ArchiveURL)
            print("Information about last session successfully saved.")
        } catch {
            print("Failed to save Information about last session.")
        }
    }
    
    public func cleanInformationAboutLastSession() {
        let informationAboutLastSession = InformationAboutLastSession(hasRentStarted: nil, orderId: nil, rentStartDate: nil)
        saveInformationAboutLastSession(informationAboutLastSession!)
        self.informationAboutLastSession = informationAboutLastSession
    }
    
    public func loadInformationAboutLastSessionFromStorage() -> InformationAboutLastSession? {
        if let nsData = NSData(contentsOf: InformationAboutLastSession.ArchiveURL) {
            do {
                let data = Data(referencing: nsData)
                if let loadedInformationAboutLastSession = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? InformationAboutLastSession {
                    return loadedInformationAboutLastSession
                }
            } catch {
                print("Couldn't load user credentials.")
                return nil
            }
        }
        return nil
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
