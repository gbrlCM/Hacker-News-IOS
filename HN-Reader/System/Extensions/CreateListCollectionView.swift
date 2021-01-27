//
//  CreateListCollectionView.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    static func createList(withStyle style: UICollectionLayoutListConfiguration.Appearance) -> UICollectionView {
        
        let layoutConfiguration = UICollectionLayoutListConfiguration(appearance: style)
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}
