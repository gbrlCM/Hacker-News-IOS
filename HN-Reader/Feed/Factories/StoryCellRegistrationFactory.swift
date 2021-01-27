//
//  StoryCellRegistrationFactory.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

final class StoryCellRegistrationFactory {
    
    static func create() -> UICollectionView.CellRegistration<UICollectionViewListCell, Story> {
        UICollectionView.CellRegistration<UICollectionViewListCell, Story> {
            (cell, indexPath, item) in
        
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.title
            contentConfiguration.textProperties.numberOfLines = 2
            contentConfiguration.textProperties.adjustsFontSizeToFitWidth = true
            contentConfiguration.textProperties.font = .systemFont(ofSize: 18, weight: .semibold)
            contentConfiguration.secondaryText = item.subtitle
            contentConfiguration.textToSecondaryTextVerticalPadding = 8
            cell.contentConfiguration = contentConfiguration
            let backgroundView = UIView()
            backgroundView.backgroundColor = .accent
            
            cell.selectedBackgroundView = backgroundView
        }
    }
}
