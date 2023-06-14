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
        self.init(string: text, attributes: attribute)
    }
}

extension String{
    func toPDF() -> Data {
        let fmt = UIMarkupTextPrintFormatter(markupText: self)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage()
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext()
        
        return pdfData.copy() as! Data
    }
}
