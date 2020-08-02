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
    
    private let URLBase: String = "https://us.2ssupport.ru/"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var orderInformatoin = OrderInformation()
    
    func load() {
        // TODO: Level 2 - Make this screen doesn't load until we get this information
        // TODO: Level 2 - Save this id in the phone memory and check if we have it before add new user
        NetworkManager.shared.getUserId().then { [weak self] response -> Promise<OrderEntity> in
            // TODO: Level 1 - Here we should change later the source of isBuy var
            guard let self = self else { return brokenPromise() }
            self.orderInformatoin.userId = response.userId
            return NetworkManager.shared.getQRCodeInformation(userId: response.userId, isBuy: false)
        }.done(on: DispatchQueue.main) { orderEntity in
            self.orderInformatoin.code = orderEntity.code
            self.orderInformatoin.orderId = orderEntity.orderId
            print("QR information has been successfully loaded.")
        }.catch { error in
            print("Error: \(error)")
        }
    }
}

