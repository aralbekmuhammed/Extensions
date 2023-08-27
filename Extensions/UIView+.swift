import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    var bordersWidth: CGFloat{
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }
    
    var bordersColor: UIColor{
        set { layer.borderColor = newValue.cgColor }
        get { layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : .clear }
    }
    
    convenience init(color: UIColor){
        self.init(frame: .zero)
        backgroundColor = color
    }
    
    convenience init(action: @escaping Closure) {
        self.init(frame: .zero)
        isUserInteractionEnabled = true
        addGestureRecognizer(TapGestureRecognizer(action))
    }
    
    static func animate(with duration: TimeInterval,
                        animation: @escaping Closure,
                        options: UIView.AnimationOptions = .transitionCrossDissolve) async {
        if duration == 0{
            animation()
            return
        }
        await withCheckedContinuation { continuation in
            UIView.animate(withDuration: duration,
                           animations: animation) { finished in
                guard finished else { return }
                continuation.resume()
            }
        }
    }
    
    func hide(from superview: UIView? = nil,
              to edge: UIRectEdge,
              duration: TimeInterval) async {
        await UIView.animate(with: duration, animation: {
            guard let superview = superview ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController?.view,
                  let ownSuperview = self.superview else { return }
            
            let rectInSuperview = ownSuperview.convert(self.frame, to: superview)
            
            var targetX: CGFloat = 0
            var targetY: CGFloat = 0
            
            switch edge{
            case .top:
                targetY = -rectInSuperview.maxY
            case .bottom:
                targetY = superview.frame.height - rectInSuperview.minY
            case .right:
                targetX = superview.frame.width - rectInSuperview.minX
            case .left:
                targetX = -rectInSuperview.maxX
            default: break
            }
            
            self.transform = .init(translationX: targetX, y: targetY)
        })
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    func circle(){
        layer.cornerRadius = frame.height / 2
    }

    func setBorder(color: UIColor, width: CGFloat){
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func addSubviews(_ subviews: [UIView]){
        subviews.forEach {
            addSubview($0)
        }
    }
        
    func addSubviews(_ subviews: UIView...){
        subviews.forEach {
            addSubview($0)
        }
    }
    
    func removeSubviews(){
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func removeConstraints(for attribute: NSLayoutConstraint.Attribute){
        let constraints = constraints.filter({ $0.firstAttribute == attribute })
        removeConstraints(constraints)
    }
    
    func removeGestureRecognizers(){
        gestureRecognizers?.removeAll()
    }
    
    func dropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension CACornerMask {
    static var topLeft: CACornerMask {
        .layerMinXMinYCorner
    }
    
    static var topRight: CACornerMask {
        .layerMaxXMinYCorner
    }
    
    static var bottomRight: CACornerMask {
        .layerMaxXMaxYCorner
 }
    
    static var bottomLeft: CACornerMask {
        .layerMinXMaxYCorner
    }
    
    static var all: CACornerMask {
        [
            .topLeft,
            .topRight,
            .bottomLeft,
            .bottomRight
        ]
    }
}
