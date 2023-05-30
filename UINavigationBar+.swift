//
//  UINavigationBar+.swift
//  Carwash
//
//  Created by Muhammed Aralbek on 04.10.2022.
//

import UIKit
 
extension UINavigationBar{
    func setAppearance(_ appearance: UINavigationBarAppearance){
        compactAppearance = appearance
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            compactScrollEdgeAppearance = appearance
        }
    }
}

