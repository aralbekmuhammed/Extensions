import UIKit.NSLayoutConstraint

extension NSLayoutConstraint{
    func withPriority(_ p: UILayoutPriority)->Self{
        priority = p
        return self
    }
    func withPriority(_ p: Int)->Self{
        priority = .init(Float(p))
        return self
    }
}
