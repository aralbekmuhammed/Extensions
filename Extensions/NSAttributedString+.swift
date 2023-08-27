import UIKit

extension NSAttributedString{
    
    convenience init(text: String,
                     color: UIColor,
                     font: UIFont,
                     kern: Double? = nil,
                     lineSpacing: Double? = nil,
                     strikethroughColor: UIColor? = nil,
                     link: String? = nil,
                     underlineColor: UIColor? = nil){
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font,
        ]
        
        if let strikethroughColor {
            attributes.updateValue(strikethroughColor, forKey: .strikethroughColor)
            attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .strikethroughStyle)
        }
        if let underlineColor{
            attributes.updateValue(underlineColor, forKey: .underlineColor)
            attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .underlineStyle)
        }
        if let kern {
            attributes.updateValue(kern, forKey: .kern)
        }
        
        if let link{
            attributes.updateValue(link, forKey: .link)
        }
        if let lineSpacing  {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = lineSpacing
            attributes.updateValue(paragraph, forKey: .paragraphStyle)
        }
        
        self.init(string: text, attributes: attributes)
    }
    
}
