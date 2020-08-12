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
    
    var orderInformation = OrderInformation()
    
    // TODO: Level 2 Think how to make optional handling in this class better
    func load(_ operationType: UmbrellaUtil.OperationType?) {
        
        let userCredentials = GlobalDataStorage.shared.userCredentials
        var isBuy = false
        if let operationType = operationType {
            isBuy = operationType == UmbrellaUtil.OperationType.buyUmbrella
        }
        
        // TODO: Level 2 - Make this screen doesn't load until we get this information
        if let userCredentials = userCredentials, let userId = userCredentials.userId {
            NetworkManager.shared.getQRCodeInformation(userId: userId, isBuy: isBuy)
                .done { orderEntity in
                    self.orderInformation.code = orderEntity.code
                    self.orderInformation.orderId = orderEntity.orderId
                    print("QR Information has been successfully loaded")
            }.catch { error in
                print("Error: \(error)")
            }
        }
    }
}

