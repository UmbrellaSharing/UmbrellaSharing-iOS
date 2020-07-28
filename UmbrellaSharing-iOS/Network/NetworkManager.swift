//
//  NetworkManager.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/28.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkManager {
    
    // TODO: Level 3 - Exctract all path in a config file or so
    // TODO: Level 1 - Implement all API calls
    
    // MARK: Properties
    
    static let shared = NetworkManager(pathBaseURL: "https://us.2ssupport.ru/")
    private let baseURL: URL
    
    // MARK: Initialization
    
    private init(pathBaseURL: String) {
        self.baseURL = URL(string: pathBaseURL)!
    }
    
    // MARK: Fetch QR Code
    // Type: GET
    func getQRCodeInformation(userId: Int, isBuy: Bool) -> Promise<OrderEntity> {
        let pathComponent = "order/getQrCodeToTake"
        let requestURL = self.baseURL.appendingPathComponent(pathComponent)
            .appending("userId", value: String(userId))
            .appending("isBuy", value: String(isBuy))
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        } .compactMap {
            return try JSONDecoder().decode(OrderEntity.self, from: $0.data)
        }
    }

    // MARK: GET ORDER INFO
    // MARK: GET QR CODE TO PASS
    // MARK: SAVE FEEDBACK
    // MARK: CAN GO FURTHER
    
    // MARK: Add New User
    // Type: GET
    // TODO: Level 2 - After Ilia transform all of this
    func getUserId() -> Promise<Int> {
        let requestURL = self.baseURL.appendingPathComponent("data/addUser")
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        }.compactMap {
            return try JSONDecoder().decode(Int.self, from: $0.data)
        }
    }
    
    // MARK: GET RATE PLAN
    // MARK: GET FAQS
    // MARK: GET POINTS
    // MARK: GET POINTS
}

extension URL {
    
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        return urlComponents.url!
    }
}
