import UIKit

extension UIButton {
    
    @IBInspectable
    var adjustFontSizeToFitWidth: Bool{
        get{ titleLabel?.adjustsFontSizeToFitWidth ?? false }
        set{ titleLabel?.adjustsFontSizeToFitWidth = newValue }
    }

}
