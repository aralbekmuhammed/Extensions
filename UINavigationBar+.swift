//
//  UINavigationBar+.swift
//  Carwash
//
//  Created by Muhammed Aralbek on 04.10.2022.
//

import UIKit
 
extension UINavigationBar{
    func setBackgroundColor(to color: UIColor){
        let appearance = UINavigationBarAppearance().then {
            $0.backgroundColor = color
            $0.shadowColor = .clear
            $0.shadowImage = nil
        }
        compactAppearance = appearance
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            compactScrollEdgeAppearance = appearance
        }

    }
}
