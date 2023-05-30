//
//  StackViewExtensions.swift
//  Carwash Merchant
//
//  Created by Мухаммед Аралбек on 30.06.2022.
//

import Foundation
import UIKit

extension UIStackView{
    func removeArrangedSubviews(){
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
        }
    }
    
    func addArrangedSubviews(_ subviews: UIView...){
        subviews.forEach {
            addArrangedSubview($0)
        }
    }
    
    convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        insets: UIEdgeInsets? = nil,
        arrangedSubviews: [UIView]
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        if let insets = insets {
            layoutMargins = insets
            isLayoutMarginsRelativeArrangement = true
        }
    }

}
