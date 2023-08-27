import UIKit

extension UICollectionView{
    
    //MARK: - Register

    func registerHeader(_ reusableView: UICollectionReusableView.Type){
        register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: .init(describing: reusableView))
    }
    
    func registerFooter(_ reusableView: UICollectionReusableView.Type){
        register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: .init(describing: reusableView))
    }
    
    func register(_ cell: UICollectionViewCell.Type){
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    //MARK: - Dequeue
    
    func dequeueHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T{
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: .init(describing: T.self),
                                         for: indexPath) as! T
    }
    
    func dequeueFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T{
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                         withReuseIdentifier: .init(describing: T.self),
                                         for: indexPath) as! T
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

}

extension UICollectionViewCell{
    
    static var identifier: String {
        String(describing: self)
    }
    
}
