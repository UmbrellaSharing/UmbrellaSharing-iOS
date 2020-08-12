//
//  FeedbackScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/16.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

class FeedbackScreenViewController: UIViewController , UITextViewDelegate {
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var submitButton: UmbrellaButton!
    @IBOutlet weak var comment: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comment.delegate = self
    }
    
    
    @IBAction func submit(_ sender: Any) {
        // TODO: Level 2 - Insert here the API call for the server side and send rating and comment
        openHomeScreen()
    }
    
    private func openHomeScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // MARK: TextViewDelegates
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        comment.text = ""
        comment.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if comment.text.isEmpty {
            comment.text = "Please, write the comment here..."
            comment.textColor = UIColor.gray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        } // Recognizes enter ket in keyboard
        
        return true
    }
}
