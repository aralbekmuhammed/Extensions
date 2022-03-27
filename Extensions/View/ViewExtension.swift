import UIKit
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    @IBInspectable
    var borderWidth: CGFloat{
        set{ layer.borderWidth = newValue }
        get{ layer.borderWidth }
    }
    
    @IBInspectable
    var borderColor: UIColor?{
        set{ layer.borderColor = newValue?.cgColor }
        get{
            if let cgColor = layer.borderColor{
                return UIColor(cgColor: cgColor)
            }else{
                return nil
            }
        }
    }
    
    func setBorder(width: CGFloat,
                   color: UIColor,
                   strokeStart: CGFloat,
                   strokeEnd: CGFloat){
        let circlePath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        // circle shape
        let circleShape = CAShapeLayer().then {
            $0.path = circlePath.cgPath
            $0.strokeColor = color.cgColor
            $0.fillColor = UIColor.clear.cgColor
            $0.lineWidth = width
            $0.strokeStart = strokeStart
            $0.strokeEnd = strokeEnd
        }
        layer.addSublayer(circleShape)
    }
    
    /// Rounds corner radius of view
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: 0.0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
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
    func removeSubviews(){
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func clip(to view: UIView, with inset: UIEdgeInsets = .zero){
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: inset.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0 - inset.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0 - inset.bottom)
        ])
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
