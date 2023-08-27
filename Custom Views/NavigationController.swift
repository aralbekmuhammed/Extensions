import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }
    
    func setUpNavBar(){
        let appearance = UINavigationBarAppearance().then {
            $0.backgroundColor = <#TODO#>
            $0.shadowColor = <#TODO#>
            $0.titleTextAttributes = [
                .font: <#TODO#>,
                .foregroundColor: <#TODO#>
            ]
        }
        navigationBar.setAppearance(appearance)
    }
    
}


