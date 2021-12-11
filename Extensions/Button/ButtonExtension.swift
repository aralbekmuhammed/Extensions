import UIKit
extension UIButton {
    func setState(_ state: ButtonState, backgroundColor: UIColor, textColor: UIColor){
        switch state{
        case .enabled:
            self.isEnabled = true
        case .disabled:
            self.isEnabled = false
        }
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
    }
    
}
