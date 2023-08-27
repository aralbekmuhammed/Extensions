import Foundation

extension Int{
    
    init?(_ number: String?) {
        if let number = number {
            self.init(number)
        }else{
            return nil
        }
    }
    
}

extension Double{
    var asPrice: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .init(identifier: "ru_KZ")
        formatter.maximumFractionDigits = 0
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
