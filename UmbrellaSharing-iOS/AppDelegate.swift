//
//  AppDelegate.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/05/22.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Ideas for the future improvements:
    // TODO: Rates should not be hardcoded
    // TODO: On all screens rename newViewController for the going to another screen methods
    // TODO: Implement better logging system
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBC1EwMA0Hc4DRq7l_wEE7FxHCG1K8GFLY")
        loadUserCredentials()
        loadInformationAboutLastSession()
        return true
    }
    
    private func loadUserCredentials() {
        GlobalDataStorage.shared.loadUserCredentials()
    }
    
    private func loadInformationAboutLastSession() {
        GlobalDataStorage.shared.loadInformationAboutLastSession()
    }
}

