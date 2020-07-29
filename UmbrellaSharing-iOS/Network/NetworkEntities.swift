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
    // TODO: Level 2 - Make sure that date can be converted in that way
    var date: Date
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

struct LocationPoints: Decodable {
    var pointId: Int
    var longitude: Double
    var latitude: Double
    var descritption: String
}
