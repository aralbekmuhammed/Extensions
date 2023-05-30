import UIKit
import Then

extension UIEdgeInsets{
    
    var horizontal: CGFloat {
        left + right
    }
    
    var vertical: CGFloat {
        top + bottom
    }

    init(equalInset: CGFloat) {
        self.init(top: equalInset, left: equalInset, bottom: equalInset, right: equalInset)
    }
    
    init(vertical: CGFloat = .zero,
         horizontal: CGFloat = .zero){
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(top: CGFloat = .zero,
         left: CGFloat = .zero,
         bottom: CGFloat = .zero,
         right: CGFloat = .zero){
        self.init()
        self.top = top
        self.bottom = bottom
        self.right = right
        self.left = left
    }
    
    static var sideInsets: UIEdgeInsets{
        .init(left: 24, right: 24)
    }

}
