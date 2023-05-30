//
//  SnapKit+.swift
//  PDF Scanner
//
//  Created by Muhammed Aralbek on 22.03.2023.
//

import SnapKit
import UIKit

extension Array where Element == UIView {
    
    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        forEach {
            $0.snp.makeConstraints(closure)
        }
    }
    
    public func remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        forEach {
            $0.snp.remakeConstraints(closure)
        }
    }
    
    public func updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        forEach {
            $0.snp.updateConstraints(closure)
        }
    }
    
    public func removeConstraints() {
        forEach {
            $0.snp.removeConstraints()
        }
    }
    

}
