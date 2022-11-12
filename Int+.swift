//
//  intExtension.swift
//  Carwash Merchant
//
//  Created by Мухаммед Аралбек on 05.06.2022.
//

import Foundation

extension Int{
    
    init?(_ number: String?) {
        if let number = number {
            self.init(number)
        }else{
            return nil
        }
    }
    
}
