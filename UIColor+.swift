//
//  UIColor+.swift
//  LED Light
//
//  Created by Muhammed Aralbek on 18.11.2022.
//

import UIKit.UIColor

extension UIColor{
    var redValue: Int{
        var red: CGFloat = 0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return Int(red * 255)
    }
    
    var greenValue: Int{
        var green: CGFloat = 0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return Int(green * 255)
    }
    
    var blueValue: Int{
        var blue: CGFloat = 0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return Int(blue * 255)
    }
    
    func lighter(by percentage: CGFloat) -> UIColor? {
         return self.adjust(by: abs(percentage) )
     }

     func darker(by percentage: CGFloat) -> UIColor? {
         return self.adjust(by: -1 * abs(percentage) )
     }

    private func adjust(by percentage: CGFloat) -> UIColor? {
         var red: CGFloat = 0,
             green: CGFloat = 0,
             blue: CGFloat = 0,
             alpha: CGFloat = 0
         
         if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
             return UIColor(red: min(red + percentage, 1.0),
                            green: min(green + percentage, 1.0),
                            blue: min(blue + percentage, 1.0),
                            alpha: alpha)
         } else {
             return nil
         }
     }
    
}
