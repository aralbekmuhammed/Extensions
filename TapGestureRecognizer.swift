//
//  TapGestureRecognizer.swift
//  TV Control
//
//  Created by Muhammed Aralbek on 07.05.2023.
//

import UIKit

class TapGestureRecognizer: UITapGestureRecognizer {

    var action: Closure?
    
    init(_ action: Closure?){
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(viewDidTap))
    }
    
    @objc
    private func viewDidTap(){
        action?()
    }

}
