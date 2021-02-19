//
//  SideBarFactory.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 29/01/21.
//

import Foundation
import UIKit

final class SidebarFactory {
    
    public func createCollectionView() -> UICollectionView {
        
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let configuration = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        return UICollectionView(frame: .zero, collectionViewLayout: configuration)
    }
    
    private func createCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, FeedSection> {
        
        return UICollectionView.CellRegistration<UICollectionViewListCell, FeedSection>{
            (cell, indexPath, item) in
           var configuration = cell.defaultContentConfiguration()
            configuration.text = item.info.name
            configuration.image = UIImage(systemName: item.info.image)
            cell.contentConfiguration = configuration
        }
    }
    
    public func createDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<SidebarViewController.SidebarSection, FeedSection> {
        
        let cellRegistration = createCellRegistration()
        
        return UICollectionViewDiffableDataSource<SidebarViewController.SidebarSection, FeedSection> (collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, data: FeedSection) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
            return cell
        }
    }
}
