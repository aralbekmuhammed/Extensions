//
//  UICollectionView+.swift
//  ChatGPT
//
//  Created by Muhammed Aralbek on 05.03.2023.
//

import UIKit

extension UICollectionView{
    
    func registerHeader(_ reusableView: UICollectionReusableView.Type){
        register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: .init(describing: reusableView))
    }
    
    func registerFooter(_ reusableView: UICollectionReusableView.Type){
        register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: .init(describing: reusableView))
    }
    
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
    
    func register(_ cell: UICollectionViewCell.Type){
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func addRefreshControl(selector: Selector){
        let rf = UIRefreshControl()
        self.refreshControl = rf
        rf.addTarget(nil,
                     action: selector,
                     for: .valueChanged)
    }
    
}

extension UICollectionViewCell{
    
    static var identifier: String {
        String(describing: self)
    }
    
}
