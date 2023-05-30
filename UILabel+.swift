//
//  UILabel+.swift
//  Carwash
//
//  Created by Muhammed Aralbek on 11.11.2022.
//

import UIKit

extension UILabel{
    convenience init(text: String? = nil,
                     font: UIFont,
                     textColor: ColorAsset = Colors.black800,
                     alignment: NSTextAlignment = .left,
                     numberOfLines: Int = 1,
                     adjustsFontSize: Bool = false){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor.color
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = adjustsFontSize
        self.numberOfLines = numberOfLines
    }
}
