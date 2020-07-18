//
//  PaymentViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/11.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import PromiseKit

class PaymentViewModel {
    
    // TODO: Make all validatoin and error check inhere
    // TODO: Exctract all api requests to the common file
    // TODO This class has to load all information
    
    // Usefull links for making URL sessions. Please use them while working on this class
    // https://learnappmaking.com/urlsession-swift-networking-how-to/
    // https://www.raywenderlich.com/3244963-urlsession-tutorial-getting-started
    // https://www.raywenderlich.com/9208-getting-started-with-promisekit
    
    
    
    private let URLBase: String = "https://us.2ssupport.ru/"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var orderInformatoin = OrderInformation()
    
    func load() {
        // TODO: Make this screen doesn't load until we get this information
        // TODO: Save this id in the phone memory and check if we have it before add new user
        fetchUserId().then { [weak self] userId -> Promise<OrderEntity> in
            // TODO: Here we should change later the source of isBuy var
            guard let self = self else { return brokenPromise() }
            self.orderInformatoin.userId = userId
            return self.fetchQRCodeInformation(userId: userId, isBuy: false)
        }.done(on: DispatchQueue.main) { orderEntity in
            self.orderInformatoin.code = orderEntity.code
            self.orderInformatoin.orderId = orderEntity.orderId
            print("QR information has been successfully loaded.")
        }.catch { error in
            print("Error: \(error)")
        }
    }
    
    func fetchUserId() -> Promise<Int> {
        let url = URL(string: URLBase + "data/addUser")!
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(Int.self, from: $0.data)
        }
    }
    
    private func fetchQRCodeInformation(userId: Int, isBuy: Bool) -> Promise<OrderEntity> {
        let urlString = URLBase + "order/getQrCodeToTake?userId=\(userId)&isBuy=\(isBuy)"
        let url = URL(string: urlString)!
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        } .compactMap {
            return try JSONDecoder().decode(OrderEntity.self, from: $0.data)
        }
    }
    
    
//
//    private func fetchUserId() -> Promise<Int> {
//
//        return Promise { seal in
//             let url = URL(string: URLBase + "data/addUser")!
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data,
//                let result = try? JSONDecoder().decode(Int.self, from: data)
//                    else {
//                        let genericError = NSError(
//                        domain: "UmbrellaSharing",
//                        code: 0,
//                        userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
//                        seal.reject(error ?? genericError)
//                        return
//                }
//
//                seal.fulfill(result)
//            }.resume()
//        }
//    }
//
    
    
//    private func fetchUserId(completion: @escaping (Int?, Error?) -> Void ) {
//        let session = URLSession.shared
//        let url = URL(string: URLBase + "data/addUser")!
//        let task = session.dataTask(with: url) { data, response, error in
//            print("POC - start fetching")
//            if error != nil {
//                // TODO: Make centrilized error processing
//                print("Error: [\(error!)]")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                (200...299).contains(httpResponse.statusCode) else {
//                    // TODO: Treat this error better
//                    print("Wrong status code")
//                    return
//            }
//
//            guard let mime = httpResponse.mimeType, mime == "application/json" else {
//                print("Wrong MIME type!")
//                return
//            }
//
//
//            if let data = data {
//                do {
//                    let value = try JSONDecoder().decode(Int.self, from: data)
//                    // I'm not sure about the next line
//                    self.orderInformatoin.userId = value
//                    completion(value, nil)
//                }
//                catch {
//                    print("JSON error: \(error.localizedDescription)")
//                }
//            }
//            print("POC - finish fetching")
//        }
//
//        task.resume()
//
//    }
    
    
    // In - nothing
    // Out - userId int
//    private func fetchUserId(completion: @escaping(Result<Int, Error>) -> Void) {
//        let path = "data/addUser"
//        let urlAddress = URLBase + path
//
//        dataTask?.cancel()
//
//
//        if var urlComponents = URLComponents(string: urlAddress) {
//            guard let url = urlComponents.url else {
//                return
//            }
//
//            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
//                defer {
//                    self?.dataTask = nil
//                }
//
//                if let error = error {
//                    print("Error: [\(error)]")
//                } else if
//                    let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//                    print("POC - data \(data)")
//                    DispatchQueue.main.async {
//                        completion(.success(1))
//                    }
//                }
//            }
//            dataTask?.resume()
//        }
//
//    }
    
}

// TODO: Extract in a separate file

func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "WeatherOrNot", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' not yet implemented."])
    seal.reject(err)
  }
}
