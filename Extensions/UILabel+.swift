import UIKit

extension UILabel{
    convenience init(text: String? = nil,
                     font: UIFont,
                     textColor: UIColor = <#TODO#>,
                     alignment: NSTextAlignment = .left,
                     numberOfLines: Int = 1,
                     adjustsFontSize: Bool = false){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = adjustsFontSize
        self.numberOfLines = numberOfLines
    }
}
