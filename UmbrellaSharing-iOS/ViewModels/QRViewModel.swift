//
//  QRViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/13.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class QRViewModel {
    
    weak var delegate: QRDataModelDelegate?
    
    func canWeProceed(orderId: Int, qrType: UmbrellaUtil.OperationType) -> Bool {
        return true
    }
    
    func getReturnCode(orderId: Int) {
        NetworkManager.shared.getReturnQRCodeInformation(orderId: orderId).done { [weak self] response in
            guard self != nil else { return }
            if let delegate = self?.delegate {
                delegate.didLoadReturnCode(code: response.code)
            }
        }.catch { error in
            print("Error: \(error)")
        }
    }
}

protocol QRDataModelDelegate: class {
    func didLoadReturnCode(code: Int)
}
