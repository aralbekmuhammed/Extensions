import UIKit
import Combine

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func showMain(){

    }
    
    func showOnboarding(completion: Closure? = nil){

    }
    
    func openAppSettings(){
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:])
    }
    
    func showRateAlert(){
        showAlert(withTitle: "Do you like the app?",
                  message: "Your feedback is always welcome",
                  actions: [
                    .init(text: "No", type: .default),
                    .init(text: "Yes", type: .default, action: { [weak self] in
                        self?.showAlert(withTitle: "Please leave a review",
                                        message: "Good reviews motivate us to work harder on the app",
                                        actions: [
                                            .init(text: "Go to the AppStore", type: .default, action: {
                                                UIApplication.shared.open(.appReviewLink)
                                            })
                                        ])
                    })
                  ])
    }
    
    private func setupViews(){
        view.backgroundColor = <#TODO#>
    }
    
}
