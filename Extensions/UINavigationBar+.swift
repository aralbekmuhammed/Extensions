import UIKit
 
extension UINavigationBar{
    func setAppearance(_ appearance: UINavigationBarAppearance){
        compactAppearance = appearance
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            compactScrollEdgeAppearance = appearance
        }
    }
    
    func setBackgroundColor(to color: UIColor){
        guard let copy = compactAppearance?.copy() as? UINavigationBarAppearance else { return }
        copy.backgroundColor = color
        copy.shadowColor = color
        setAppearance(copy)
    }
}

