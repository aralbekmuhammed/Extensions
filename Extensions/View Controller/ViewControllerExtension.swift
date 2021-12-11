import UIKit
import StoreKit
//import JGProgressHUD
//let spinner = JGProgressHUD(style: .dark)
struct AlertAction{
    let text: String
    let type: UIAlertAction.Style
    var action: ((UIAlertAction) -> Void)? = nil
}
extension UIViewController {
    func presentRateAlert(){
        guard let window = view.window,
        let scene = window.windowScene else{return}
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    func callToPhoneNumber(_ phoneNumber: String){
        guard let number = URL(string: "tel://" + phoneNumber) else {print("looks like it's something wrong with phone number"); return }
        UIApplication.shared.open(number)
    }
    func showAlert(withTitle: String?, message: String?, style: UIAlertController.Style = .alert, actions: [AlertAction] = [AlertAction(text: "Ок", type: .default)]){
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: style)
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.text, style: action.type, handler: action.action))
        }
        present(alert, animated: true, completion: nil)
    }
    func presentViewController(viewController: UIViewController,
                               presentationStyle: UIModalPresentationStyle,
                               transitionStyle: UIModalTransitionStyle,
                               animated: Bool){
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        present(viewController, animated: animated)
    }
}

