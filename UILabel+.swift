//
//  UILabel+.swift
//  Carwash
//
//  Created by Muhammed Aralbek on 11.11.2022.
//

import UIKit

extension UILabel{
    convenience init(text: String,
                     font: UIFont,
                     textColor: UIColor = .Black,
                     alignment: NSTextAlignment = .left){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
