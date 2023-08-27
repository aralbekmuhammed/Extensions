import UIKit
import Combine

extension UITextField {
    
    var isEmpty: Bool{
        (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
    
    func editingPublisher() -> AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UITextField.textDidBeginEditingNotification),
            NotificationCenter.default
                .publisher(for: UITextField.textDidEndEditingNotification)
        )
        .map{
            ($0.object as? UITextField)?.isFirstResponder ?? false
        }
        .eraseToAnyPublisher()
    }
    
    func addToolbar(withDismissText text: String = "Done"){
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: text, style: .done,
                                         target: self, action: #selector(endEditing))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
    
}

