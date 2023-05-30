import UIKit
import StoreKit
import SafariServices
import AVFoundation
import AVKit
import Then

struct AlertAction{
    let text: String
    let type: UIAlertAction.Style
    var action: ((UIAlertAction) -> Void)? = nil
}

enum NavigationBarEdge{
    case left,right
}

typealias Closure = () -> ()

func takeScreenshot() -> UIImage? {
    var screenshotImage :UIImage?
    let layer = UIApplication.shared.keyWindow!.layer
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
    guard let context = UIGraphicsGetCurrentContext() else {return nil}
    layer.render(in:context)
    screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshotImage
}

extension UIViewController {
    func setDismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Navigation Bar
    func setNavBar(cornerRadius: CGFloat,
                   color: UIColor){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        let navBarView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: navBarHeight))
        navBarView.do {
            $0.roundCorners([.bottomRight, .bottomLeft], radius: cornerRadius)
            $0.backgroundColor = color
        }
        self.view.addSubview(navBarView)
    }
    
    var navBarHeight: CGFloat{
        UIApplication.shared.statusBarFrame.size.height +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func presentErrorAlert(completionHandler: Closure? = nil){
        showAlert(withTitle: "Ошибка",
                  message: "Что-то пошло не так. Попробуйте позже",
                  actions: [AlertAction(text: "Ок",
                                        type: .default, action: { _ in
            completionHandler?()
        })])
    }
    
    func addBackButtonWithPop(tintColor: UIColor = Colors.black800.color, action: Selector = #selector(pop)){
        let image = UIImage(systemName: "arrow.left")?
            .withTintColor(tintColor, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(weight: .medium))
        addButton(to: .left,
                  withImage: image,
                  selector: action)
    }
    
    @objc
    private func pop(){
        navigationController?.popViewController(animated: true)
    }
    
    @discardableResult
    func addButton(to edge: NavigationBarEdge,
                   withImage image: UIImage? = nil,
                   spacing: CGFloat = .zero,
                   title: String? = nil,
                   titleColor: UIColor = Colors.black800.color,
                   titleFont: UIFont = .Body1(.medium),
                   contentInset: UIEdgeInsets = .init(top: 5,
                                                      left: 5,
                                                      bottom: 5,
                                                      right: 5),
                   selector: Selector?) -> UIBarButtonItem{
        let button = UIButton().then {
            // Title
            $0.setTitle(title,
                        for: .normal)
            $0.setTitleColor(titleColor,
                             for: .normal)
            $0.titleLabel?.font = titleFont
            
            // Inset
            if let _ = image,
               let _ = title{
                $0.titleEdgeInsets.left = spacing
                $0.titleEdgeInsets.right = -spacing
            }
            $0.contentEdgeInsets = contentInset
            if edge == .right{
                let right = contentInset.right
                $0.contentEdgeInsets.right = contentInset.left
                $0.contentEdgeInsets.left = right
            }
            
            // Image
            $0.setImage(image, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            
            // Transforming
            if edge == .right{
                $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
            
            if let selector{
                $0.addTarget(self,
                             action: selector,
                             for: .touchUpInside)                
            }
        }
        let buttonItem = UIBarButtonItem(customView: button)
        switch edge {
        case .left:
            if navigationItem.leftBarButtonItems == nil{
                navigationItem.leftBarButtonItems = [buttonItem]
            }else{
                navigationItem.leftBarButtonItems?.append(buttonItem)
            }
        case .right:
            if navigationItem.rightBarButtonItems == nil{
                navigationItem.rightBarButtonItems = [buttonItem]
            }else{
                navigationItem.rightBarButtonItems?.append(buttonItem)
            }
        }
        return buttonItem
    }
    func presentRateAlert(){
        guard let window = view.window,
              let scene = window.windowScene else{return}
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    func add(_ child: UIViewController, to view: UIView, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func openWebsite(_ url: URL){
        present(SFSafariViewController(url: url),
                animated: true)
    }
    
    func openVideo(from url: URL){
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController().then {
            $0.player = player
        }
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    func callToPhoneNumber(_ phoneNumber: String){
        guard let number = URL(string: "tel://" + phoneNumber) else {print("looks like it's something wrong with phone number"); return }
        UIApplication.shared.open(number)
    }
    
    func showAlert(withTitle: String?,
                   message: String?,
                   alpha: CGFloat = 1,
                   style: UIAlertController.Style = .alert,
                   actions: [AlertAction] = [AlertAction(text: "Ок", type: .default)]){
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: style)
        alert.view.alpha = alpha
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.text, style: action.type, handler: action.action))
        }
        present(alert, animated: true, completion: nil)
    }
    
    func presentViewController(viewController: UIViewController,
                               presentationStyle: UIModalPresentationStyle = .fullScreen,
                               transitionStyle: UIModalTransitionStyle = .coverVertical,
                               animated: Bool = true,
                               completionHandler: Closure? = nil){
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        present(viewController, animated: animated, completion: completionHandler)
    }
    
    
}

