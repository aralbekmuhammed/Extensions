import UIKit
import StoreKit
import SafariServices
import AVFoundation
import AVKit
//import JGProgressHUD
//let spinner = JGProgressHUD(style: .light)
struct AlertAction{
    let text: String
    let type: UIAlertAction.Style
    var action: ((UIAlertAction) -> Void)? = nil
}

func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
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
    var navBarHeight: CGFloat{
        UIApplication.shared.statusBarFrame.size.height +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)

    }
    func setNavBar(cornerRadius: CGFloat,
                   color: UIColor){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        let navBarView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: navBarHeight))
        navBarView.do {
            $0.roundCorners(corners: [.bottomRight, .bottomLeft], radius: cornerRadius)
            $0.backgroundColor = color
        }
        self.view.addSubview(navBarView)
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
    func openWebsite(_ string: String){
        guard let url = URL(string: string) else{return}
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

