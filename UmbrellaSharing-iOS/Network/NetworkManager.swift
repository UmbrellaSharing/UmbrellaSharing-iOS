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
    // TODO: Level 3 - Make all validatoin and error check inhere
    
    // Usefull links for making URL sessions. Please use them while working on this class
    // https://learnappmaking.com/urlsession-swift-networking-how-to/
    // https://www.raywenderlich.com/3244963-urlsession-tutorial-getting-started
    // https://www.raywenderlich.com/9208-getting-started-with-promisekit
    
    // MARK: Properties
    
    static let shared = NetworkManager(pathBaseURL: "https://us.2ssupport.ru/")
    private let baseURL: URL
    
    // MARK: Initialization
    
    private init(pathBaseURL: String) {
        self.baseURL = URL(string: pathBaseURL)!
    }
    
    // MARK: Get QR Code to Rent or To Buy an Umbrella
    // Type: GET
    func getQRCodeInformation(userId: String, isBuy: Bool) -> Promise<OrderEntity> {
        let pathComponent = "order/getQrCodeToTake"
        let requestURL = self.baseURL.appendingPathComponent(pathComponent)
            .appending("userId", value: userId)
            .appending("isBuy", value: String(isBuy))
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        } .compactMap {
            return try JSONDecoder().decode(OrderEntity.self, from: $0.data)
        }
    }

    // MARK: Get QR Code to Return an Umbrella
    // Type: Get
    func getReturnQRCodeInformation(orderId: Int) -> Promise<ReturnEntity> {
        let pathComponent = "order/getQrCodeToPass"
        let requestURL = self.baseURL.appendingPathComponent(pathComponent)
            .appending("orderId", value: String(orderId))
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        } .compactMap {
            return try JSONDecoder().decode(ReturnEntity.self, from: $0.data)
        }
    }
    
    // MARK: Save User's Feedback
    //Type: POST
    // TODO: Level 2 After Iliya check the server, test this part, since for right now it returns 404 error
    // TODO: Level 2 Think about how it could be implemented in more consistent way
    func postFeedback(orderId: Int, feedback: String, mark: Int) {
        let requestURL = self.baseURL.appendingPathComponent("order/saveFeedback")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = [
            "orderId": String(orderId),
            "feedback": feedback,
            "mark": String(mark)
        ]
        // TODO: Level 3 - Handle this serialization error better
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { _, _, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    // MARK: Asking The Server If QR Code Was Scanned
    // Type: Get
    func getCanGoFurther(orderId: Int, qrType: Int) -> Promise<PassEntity> {
        let pathComponent = "order/canGoFurther"
        let requestURL = self.baseURL.appendingPathComponent(pathComponent)
            .appending("orderId", value: String(orderId))
            .appending("qrType", value: String(qrType))
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        } .compactMap {
            return try JSONDecoder().decode(PassEntity.self, from: $0.data)
        }
    }
    
    // MARK: Add New User
    // Type: GET
    func getUserId() -> Promise<UserEntity> {
        let requestURL = self.baseURL.appendingPathComponent("data/addUser")
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        }.compactMap {
            return try JSONDecoder().decode(UserEntity.self, from: $0.data)
        }
    }
    
    // MARK: Get The Information About Rate Plan
    // Type: Get
    func getRatePlan() -> Promise<[RatePlanEntity]> {
        let requestURL = self.baseURL.appendingPathComponent("data/getRatePlan")
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        }.compactMap {
            return try JSONDecoder().decode([RatePlanEntity].self, from: $0.data)
        }
    }
    
    // MARK: Fetch All Frequently Asked Question
    // Type: GET
    func getFAQ() -> Promise<[FAQEntity]> {
        let requestURL = self.baseURL.appendingPathComponent("data/getFaqs")
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        }.compactMap {
            return try JSONDecoder().decode([FAQEntity].self, from: $0.data)
        }
    }
    
    // MARK: Fetch All LocationPoints
    // Type: GET
    func getLocationPoints() -> Promise<[LocationPointEntity]> {
        let requestURL = self.baseURL.appendingPathComponent("data/getPoints")
        return firstly {
            URLSession.shared.dataTask(.promise, with: requestURL)
        }.compactMap {
            return try JSONDecoder().decode([LocationPointEntity].self, from: $0.data)
        }
    }
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

func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "WeatherOrNot", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' not yet implemented."])
    seal.reject(err)
  }
}
