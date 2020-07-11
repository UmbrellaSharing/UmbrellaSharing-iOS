//
//  PaymentViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/11.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class PaymentViewModel {
    
    private let URLBase: String = "https://us.2ssupport.ru/"
    
    // TODO: Exctract all api requests to the common file
    // TODO This class has to load all information
    // TODO: RIGHT NOW HOW TO REMOVE POD DEPENDECIES FROM GIT
    
    
    // Step to do:
    // 1. Implement fetch User method
    // 2. Implement fetch QR code method
    // 3. Make a chain
    
    
    
    
    
    func load() {
        
            // Step 1. Create a new user and set this user id to the stored object of order
            // Step 2. Download all information for the generating QR Code
        
        
    }
    
    
    // In - nothing
    // Out - userId int
    private func fetchUserId() {
        
    }
    
    // In - userId (int), isBuy (bool)
    // Out - orderId (int), code (int)
    private func fetchQRCodeInformation() {
        
    }
    
}
