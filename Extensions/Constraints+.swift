import SnapKit
import UIKit

extension UIView {
    
    public func square(_ ratio: Float = 1) {
        snp.makeConstraints { make in
            make.width.equalTo(snp.height).multipliedBy(ratio)
        }
    }

}

extension NSLayoutConstraint{
    
    func withPriority(_ p: UILayoutPriority) -> Self {
        priority = p
        return self
    }
    
    func withPriority(_ p: Int) -> Self {
        priority = .init(Float(p))
        return self
    }
    
}

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
