import UIKit

class TapGestureRecognizer: UITapGestureRecognizer {

    var action: Closure?
    
    init(_ action: Closure?){
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(viewDidTap))
    }
    
    @objc
    private func viewDidTap(){
        action?()
    }

}
