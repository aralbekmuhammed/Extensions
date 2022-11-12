import UIKit
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    @IBInspectable
    var bordersWidth: CGFloat{
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }
    
    @IBInspectable
    var bordersColor: UIColor{
        set { layer.borderColor = newValue.cgColor }
        get { layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : .clear }
    }
    
    /// Rounds corner radius of view
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    /// Circles View
    func circle(){
        layer.cornerRadius = frame.height / 2
    }
    /// Sets border to view
    func setBorder(color: UIColor, width: CGFloat){
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func addSubviews(_ subviews: [UIView]){
        subviews.forEach {
            addSubview($0)
        }
    }

    func removeSubviews(){
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func clip(to view: UIView,
              with inset: UIEdgeInsets = .zero,
              priority: UILayoutPriority = .required){
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top).withPriority(priority),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: inset.left).withPriority(priority),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0 - inset.right).withPriority(priority),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0 - inset.bottom).withPriority(priority)
        ])
    }
    
    func removeConstraints(for attribute: NSLayoutConstraint.Attribute){
        let constraints = constraints.filter({ $0.firstAttribute == attribute })
        removeConstraints(constraints)
    }
    
    func removeGestureRecognizers(){
        gestureRecognizers?.removeAll()
    }
    /// Drops shadow to view
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIImageView{
    func changeImageWithAnimation(toImage image: UIImage, duration: CFTimeInterval){
        let animation = CABasicAnimation(keyPath: "contents")
        animation.fromValue = self.image
        animation.toValue = image
        animation.duration = duration
        layer.add(animation, forKey: "contents")
        self.image = image
    }
}
