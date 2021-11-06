import UIKit
extension UITableView{
    func addRefreshControl(selector:Selector){
        let rf = UIRefreshControl()
        self.refreshControl = rf
        rf.addTarget(nil, action: selector, for: .valueChanged)
    }
}
