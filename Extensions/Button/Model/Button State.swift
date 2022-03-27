/// Changes isEnabled value of button and it's background color
enum ButtonState {
    case enabled
    case disabled
    mutating func toggle(){
        if self == .enabled{
            self = .disabled
        }else{
            self = .enabled
        }
    }
}
