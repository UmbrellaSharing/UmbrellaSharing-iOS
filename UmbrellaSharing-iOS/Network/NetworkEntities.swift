//
//  NetworkEntities.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/29.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

struct OrderEntity: Decodable {
    var orderId: Int
    var code: Int
}

struct ReturnEntity: Decodable {
    var code: Int
}

struct PassEntity: Decodable {
    var date: String
}

struct UserEntity: Decodable {
    var userId: Int
}

struct RatePlanEntity: Decodable {
    var rateItemId: Int
    var ratePlan: Int
    var minTime: Int
    var maxTime: Int
    var description: Int
    var price: Int
    var isBuy: Bool
}

struct FAQEntity: Decodable {
    var faqId: Int
    var question: String
    var answer: String
}

struct LocationPointEntity: Decodable {
    var pointId: Int
    var name: String
    var longitude: Double
    var latitude: Double
    var description: String
}

struct FeedbackEntity: Codable {
    var orderId: Int
    var feedback: String
    var mark: Int
}
