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
    
    private func createCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, FeedSectionInfo> {
        
        return UICollectionView.CellRegistration<UICollectionViewListCell, FeedSectionInfo>{
            (cell, indexPath, item) in
           var configuration = cell.defaultContentConfiguration()
            configuration.text = item.name
            configuration.image = UIImage(systemName: item.image)
            cell.contentConfiguration = configuration
        }
    }
    
    public func createDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<SidebarViewController.SidebarSection, FeedSectionInfo> {
        
        let cellRegistration = createCellRegistration()
        
        return UICollectionViewDiffableDataSource<SidebarViewController.SidebarSection, FeedSectionInfo> (collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, data: FeedSectionInfo) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
            return cell
        }
    }
}
