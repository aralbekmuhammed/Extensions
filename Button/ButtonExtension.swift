import UIKit
extension UIButton {
    
    @IBInspectable
    var adjustFontSizeToFitWidth: Bool{
        get{ titleLabel?.adjustsFontSizeToFitWidth ?? false }
        set{ titleLabel?.adjustsFontSizeToFitWidth = newValue }
    }

}

class Button: UIButton {
    
    var action: Closure?
    
    init(action: Closure? = nil) {
        self.action = action
        super.init(frame: .zero)
        
        addTarget(self,
                  action: #selector(buttonTapped),
                  for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc
    private func buttonTapped(){
        action?()
    }
    
}
