import UIKit

class Button: UIButton {
    
    var action: Closure?
    
    init(title: String? = nil,
         _ action: Closure? = nil) {
        self.action = action
        super.init(frame: .zero)
        setTitle(title, for: .normal)
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
