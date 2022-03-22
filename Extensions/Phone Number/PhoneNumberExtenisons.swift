import Foundation
func formatPhoneNumber(phoneNumber: String, pattern: String = "(###) ###-####") -> String {
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
func getPhoneNumber(from text: String) -> Int?{
    var phoneNumber = text.replacingOccurrences(of: "+7", with: "8")
    phoneNumber = phoneNumber.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
    return Int(phoneNumber)
}
