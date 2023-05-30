//
//  UIImageView+.swift
//  Chromecast
//
//  Created by Muhammed Aralbek on 18.12.2022.
//

import UIKit

extension UIImageView{
    
    convenience init(image: UIImage? = nil, contentMode: UIImageView.ContentMode){
        self.init(image: image)
        self.contentMode = contentMode
    }
    
    func setImage(from link: URL){
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: link){
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
        }
    }
    
    func changeImage(to image: UIImage?, duration: TimeInterval){
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.image = image
        }
    }
    
}
