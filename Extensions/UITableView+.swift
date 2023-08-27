import UIKit

extension UITableView{
    
    //MARK: - Dequeue
    
    func dequeueCell<T: UITableViewCell>() -> T {
        dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>() -> T{
        dequeueReusableHeaderFooterView(withIdentifier: .init(describing: T.self)) as! T
    }
    
    func dequeueFooter<T: UITableViewHeaderFooterView>() -> T{
        dequeueReusableHeaderFooterView(withIdentifier: .init(describing: T.self)) as! T
    }
    
    //MARK: - Header
    
    func register(_ cell: UITableViewCell.Type){
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func registerHeader(_ header: UITableViewHeaderFooterView.Type){
        register(header, forHeaderFooterViewReuseIdentifier: .init(describing: header))
    }
    
    func registerFooter(_ footer: UITableViewHeaderFooterView.Type){
        register(footer, forHeaderFooterViewReuseIdentifier: .init(describing: footer))
    }
    
    func registerNib(_ cell: UITableViewCell.Type){
        register(.init(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
    }
    
}


extension UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
}

extension IndexPath {
    init(_ row: Int) {
        self.init(row: row, section: 0)
    }
}
