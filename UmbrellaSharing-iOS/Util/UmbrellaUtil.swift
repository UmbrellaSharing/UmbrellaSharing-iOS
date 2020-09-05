//
//  UmbrellaUtil.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/13.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class UmbrellaUtil {
    
    enum OperationType: Int, Codable {
        case buyUmbrella = 1
        case rentUmbrella
        case returnUmbrella
    }
    
    enum MapMode {
        case locationsMode
        case rentalMode
    }
    
    static func generateCurrentDateInGMT3Format() -> Date? {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 3600 * 3)
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateString = formatter.string(from: date)
        let currentDate = formatter.date(from: dateString)
        return currentDate
    }
    
    static func transformStringToDate(stringDate: String) -> Date? {
        let isoDate = stringDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        if let date = dateFormatter.date(from: isoDate) {
            return date
        } else {
            return nil
        }
    }
}
