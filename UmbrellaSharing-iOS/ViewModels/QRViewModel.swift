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
    
    func canWeProceed(orderId: Int, qrType: UmbrellaUtil.OperationType) {
        NetworkManager.shared.getCanGoFurther(orderId: orderId, qrType: qrType.rawValue).done { [weak self] response in
            guard self != nil else { return }
            if let delegate = self?.delegate {
                let currentDate = UmbrellaUtil.generateCurrentDateInGMT3Format()
                if let currentDate = currentDate {
                    delegate.qrCodeHasBeenScanned(startTime: currentDate)
                }
            }
        }.catch { error in
            print("Error: \(error)")
            if let delegate = self.delegate {
                delegate.qrCodeHasNotBeenScanned()
            }
        }
    }
    
    func getQRCode(userId: String, isBuy: Bool) {
        NetworkManager.shared.getQRCodeInformation(userId: userId, isBuy: isBuy)
            .done { [weak self] orderEntity in
                guard self != nil else { return }
                if let delegate = self?.delegate {
                    delegate.didLoadQRCode(orderId: orderEntity.orderId, code: orderEntity.code)
                }
        }.catch { error in
            print("Error: \(error)")
        }
    }
    
    func getReturnQRCode(orderId: Int) {
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
    
    func didLoadQRCode(orderId: Int, code: Int)
    
    func qrCodeHasBeenScanned(startTime: Date)
    
    func qrCodeHasNotBeenScanned()
}
