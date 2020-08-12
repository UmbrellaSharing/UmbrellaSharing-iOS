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
    
    var orderInformatoin = OrderInformation()
    
    func load(_ operationType: UmbrellaUtil.OperationType?) {
        // TODO: Level 2 Think how to make this optional handling better
        var isBuy = false
        
        if let operationType = operationType {
            isBuy = operationType == UmbrellaUtil.OperationType.buyUmbrella
        }
        
        // TODO: Level 2 - Make this screen doesn't load until we get this information
        // TODO: Level 2 - Save this id in the phone memory and check if we have it before add new user
        NetworkManager.shared.getUserId().then { [weak self] response -> Promise<OrderEntity> in
            guard let self = self else { return brokenPromise() }
            self.orderInformatoin.userId = response.userId
            return NetworkManager.shared.getQRCodeInformation(userId: response.userId, isBuy: isBuy)
        }.done(on: DispatchQueue.main) { orderEntity in
            self.orderInformatoin.code = orderEntity.code
            self.orderInformatoin.orderId = orderEntity.orderId
            print("QR information has been successfully loaded.")
        }.catch { error in
            print("Error: \(error)")
        }
    }
}

