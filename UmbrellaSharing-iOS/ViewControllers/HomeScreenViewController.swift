//
//  ViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/05/22.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    // TODO: Think do we really need all of those params here? Just occupy a lot of space
    @IBOutlet weak var rentPriceHeaderLabel: UILabel!
    @IBOutlet weak var firstOptionRentLabel: UILabel!
    @IBOutlet weak var secondOptionRentLabel: UILabel!
    @IBOutlet weak var thirdOptionRentLabel: UILabel!
    @IBOutlet weak var firstOptionRentPriceLabel: UILabel!
    @IBOutlet weak var secondOptionRentPriceLabel: UILabel!
    @IBOutlet weak var thirdOptionRentPriceLabel: UILabel!
    @IBOutlet weak var buyPriceHeaderLabel: UILabel!
    @IBOutlet weak var firstOptionBuyLabel: UILabel!
    @IBOutlet weak var firstOptionBuyPriceLabel: UILabel!
    
    @IBOutlet weak var rentButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var checkLocationsButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInterface()
    }
    
    @IBAction func checkLocations(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func initInterface() {
        // TODO: Exctract all constant string to the separate file
        // TODO: Check if all versions of iPhone follow the design
        
        // MARK: Init labels
        
        rentPriceHeaderLabel.text = "Rental Rate:"
        firstOptionRentLabel.text = "Less than an hour"
        firstOptionRentPriceLabel.text = "50 rub"
        secondOptionRentLabel.text = "Less than a day"
        secondOptionRentPriceLabel.text = "100 rub"
        thirdOptionRentLabel.text = "More than a day"
        thirdOptionRentPriceLabel.text = "300 rub"
        buyPriceHeaderLabel.text = "Buy Rate:"
        firstOptionBuyLabel.text = "Buy an umbrella"
        firstOptionBuyPriceLabel.text = "300 rub"
        
        // MARK: Init buttons
        rentButton.setTitle("Rent an Umbrella", for: .normal)
        buyButton.setTitle("Buy an Umbrella", for: .normal)
        
        checkLocationsButton.setTitle("Check Locations on the Map", for: .normal)
    }
}

