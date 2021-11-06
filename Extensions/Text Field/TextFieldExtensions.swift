import UIKit
extension UITextField{
    func addToolbar(withDismissText text: String = "Done"){
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: text, style: .done,
                                         target: self, action: #selector(endEditing))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
}
public func getAttribute(text: String, fontName: String, fontSize: CGFloat, color: UIColor)->NSAttributedString{

    let font = UIFont(name: fontName, size: fontSize)!
    return NSAttributedString(string: text, attributes: [
                                NSAttributedString.Key.foregroundColor : color,
                                NSAttributedString.Key.font : font])
}
