import UIKit
import Combine

extension UITextField{
    
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
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
    
    var editingPublisher: AnyPublisher<Bool, Never> {
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
    
    var isEmpty: Bool{
        (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
}
extension UITextView{
    
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextView)?.text  ?? "" }
            .eraseToAnyPublisher()
    }

    func editingPublisher() -> AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UITextView.textDidBeginEditingNotification),
            NotificationCenter.default
                .publisher(for: UITextView.textDidEndEditingNotification)
        )
        .map{
            ($0.object as? UITextView)?.isFirstResponder ?? false
        }
        .eraseToAnyPublisher()
    }
    
    var isEmpty: Bool{
        (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    func addToolbar(withDismissText text: String = "Done"){
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: text, style: .done,
                                         target: self, action: #selector(endEditing))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
