//
//  QRViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/13.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class QRViewModel {
    
    func canWeProceed(orderId: Int, qrType: UmbrellaUtil.OperationType) -> Bool {
        // TODO: Level 2 - This suppose to call API "/Order/CanGoFurther" - When Iliya fix the API
        return true
    }
    
}
