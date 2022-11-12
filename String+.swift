import UIKit
public func getAttributedString(text: String,
                                color: UIColor,
                                font: UIFont,
                                kern: Double? = nil,
                                lineSpacing: Double? = nil,
                                strikethroughColor: UIColor? = nil,
                                link: String? = nil,
                                underlineColor: UIColor? = nil) -> NSAttributedString{
    var attribute: [NSAttributedString.Key: Any] = [
        .foregroundColor: color,
        .font: font,
        .strikethroughStyle: (strikethroughColor != nil) ? NSUnderlineStyle.single.rawValue : 0,
        .strikethroughColor: strikethroughColor ?? .clear,
        .underlineStyle: (underlineColor != nil) ? NSUnderlineStyle.single.rawValue : 0,
        .underlineColor: underlineColor ?? .clear
    ]
    if let kern = kern {
        attribute.updateValue(kern, forKey: .kern)
    }
    
    if let link{
        attribute.updateValue(link, forKey: .link)
    }
    
    if let lineSpacing = lineSpacing {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = lineSpacing
        attribute.updateValue(paragraph, forKey: .paragraphStyle)
    }
    let finalText = NSAttributedString(string: text, attributes: attribute)
    return finalText
}

