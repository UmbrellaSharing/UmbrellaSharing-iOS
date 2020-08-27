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

    // TODO: Level 3 -Implement better file structure
    // TODO: Level 3 -Implement some icon for the app
    // TODO: Level 3 -Adapt screens for all models
    // TODO: Level 3 - Make all needed func private
    // TODO: Level 3 - Comments
    // TODO: Level 2 - Exctract all logic to view model in all classes
    // TODO: Level 3 - Implement better logging system
    // TODO: Level 2 - Feature - Add FAQ to all screens
    // TODO: Level 3 - Adopt common convention - adopt protocols on an extension to the view controller. Page 129 in iOS book
    // TODO: Level 3 - If there is no internet, then show it to user
    // TODO: Level 3 - If more than 300 rubles, than you don't need to give this umbrella back anymore

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
    
    // TODO: Level 3 - Can we remove those two methods?
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

