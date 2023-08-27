import Foundation

struct PhoneNumberManager{
    
    static func formatPhoneNumber(phoneNumber: String, pattern: String = "+7 (###) ###-##-##") -> String {
        let replacmentCharacter: Character = "#"
        var pureNumber = phoneNumber.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber}
            let stringIndex = String.Index(utf16Offset: index, in: pureNumber)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    static func getPhoneNumber(from text: String) -> Int?{
        var phoneNumber = text.replacingOccurrences(of: "+7", with: "")
        if phoneNumber.hasPrefix("8"){
            phoneNumber.removeFirst()
        }
        phoneNumber = phoneNumber.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        phoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        return Int(phoneNumber)
    }
    
}
