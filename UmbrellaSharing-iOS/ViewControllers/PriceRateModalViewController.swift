//
//  PriceRateModalViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/22.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class PriceRateModalViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var popupView: UIView!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initModalView()
    }
    
    // MARK: - Private Methods
    
    private func initModalView() {
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    
    // MARK: - IB Actions
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Touch Method
    
    /** Close popup view if user touches anywhere but popup view*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != popupView {
            dismiss(animated: true, completion: nil)
        }
    }
}
