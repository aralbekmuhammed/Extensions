import UIKit
public func getAttributedString(text: String,
                                color: UIColor,
                                font: UIFont = UIFont.systemFont(ofSize: 18),
                                strikethroughColor: UIColor? = nil,
                                underlineColor: UIColor? = nil) -> NSAttributedString{
    let attribute: [NSAttributedString.Key: Any] = [
        .foregroundColor: color,
        .font: font,
        .strikethroughStyle: (strikethroughColor != nil) ? NSUnderlineStyle.single.rawValue : 0,
        .strikethroughColor: strikethroughColor ?? .clear,
        .underlineStyle: (underlineColor != nil) ? NSUnderlineStyle.single.rawValue : 0,
        .underlineColor: underlineColor ?? .clear
    ]
    let finalText = NSAttributedString(string: text, attributes: attribute)
    return finalText
}
extension NSMutableAttributedString{
    func addSpace(){
        append(NSAttributedString(string: " "))
    }
}
