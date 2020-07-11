//
//  QRCodeScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/09.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class QRCodeScreenViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UmbrellaButton!
    @IBOutlet weak var backButton: UmbrellaButton!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    var orderInformation: OrderInformation?
    
    override func viewDidLoad() {
        // TODO: We need to store qr code somewhere
        // TODO: We need to init qr code
        super.viewDidLoad()
        
        if let orderInformation = orderInformation {
            
            print("POC from QR screen \(orderInformation)")
        }
        
        initView()
    }
    
    private func initView() {
        continueButton.setTitle("Continue", for: .normal)
        backButton.setTitle("Go Back", for: .normal)
        
        // Generating QR
        if let orderInformation = orderInformation, let code = orderInformation.code {
            qrCodeImageView.image = generateQRCode(from: String(code))
        }
        
    }
    
    @IBAction func pressContinue(_ sender: Any) {
        // We can't just press - we need to check if the operation was sumbitted
        print("POC - pressed")
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: Understand what does it mean
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

    
    
}
