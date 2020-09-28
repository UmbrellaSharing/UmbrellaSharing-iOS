//
//  FeedbackScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/16.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class FeedbackScreenViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var comment: UITextView!
    
    // MARK: - Private
    
    private let feedbackViewModel = FeedbackViewModel()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comment.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func openHomeScreen() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IB Actions
    
    @IBAction func submit(_ sender: Any) {
        let orderId = GlobalDataStorage.shared.informationAboutLastSession?.orderId
        feedbackViewModel.sentFeedback(orderId: orderId, feedback: comment.text, mark: ratingControl.rating)
        GlobalDataStorage.shared.cleanInformationAboutLastSession()
        openHomeScreen()
    }
}

extension FeedbackScreenViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        comment.text = ""
        comment.textColor = UIColor.black
        comment.layer.borderColor = UmbrellaUtil.getUIColor(hex: "#2C5F90")?.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        comment.layer.borderColor = UmbrellaUtil.getUIColor(hex: "#AAAAAA")?.cgColor
        if comment.text.isEmpty {
            comment.text = "I liked the most..."
            comment.textColor = UIColor.gray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        } // Recognizes enter key in keyboard
        return true
    }
}

