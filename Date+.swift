//
//  DateExtension.swift
//  Carwash Merchant
//
//  Created by Мухаммед Аралбек on 14.06.2022.
//

import Foundation

extension Date{
    
    var millisecondsSince1970: TimeInterval{
        self.timeIntervalSince1970 * 1000
    }
    
    
    init(millisecondsSince1970: TimeInterval){
        let seconds = millisecondsSince1970 / 1000
        self.init(timeIntervalSince1970: seconds)
    }
    
    init?(millisecondsSince1970: String){
        guard let timeInterval = TimeInterval(millisecondsSince1970) else{ return nil }
        let seconds = timeInterval / 1000
        self.init(timeIntervalSince1970: seconds)
    }
    
}

extension Locale {
    static func preferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}

extension DateFormatter{
    convenience init(dateFormat: String){
        self.init()
        self.dateFormat = dateFormat
        self.locale = .preferredLocale()
    }
}
