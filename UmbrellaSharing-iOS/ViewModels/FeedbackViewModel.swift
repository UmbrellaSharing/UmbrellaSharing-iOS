//
//  FeedbackViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/22.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class FeedbackViewModel {
    
    func sentFeedback(orderId: Int?, feedback: String, mark: Int) {
        if let orderId = orderId {
            let feedbackEnity = FeedbackEntity(orderId: orderId, feedback: feedback, mark: mark)
            NetworkManager.shared.postFeedback(feedbackEnity)
        }
    }
}
