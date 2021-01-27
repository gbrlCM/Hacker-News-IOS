//
//  StoryDataSourceFactory.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

final class StoryDataSourceFactory {
    
    static func create(for collectionView: UICollectionView, cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Story>) -> UICollectionViewDiffableDataSource<CollectionViewSection, Story> {
        
        UICollectionViewDiffableDataSource<CollectionViewSection, Story>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, data: Story) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
            
            //REFACTOR
            cell.accessories = [.disclosureIndicator()]
            
            return cell
        }
    }
}
