//
//  StoryHeaderRegistrationFactory.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 28/01/21.
//

import Foundation
import UIKit

final class StoryHeaderRegistrationFactory {
    
    static func create(notificationCenter: NotificationCenter) -> UICollectionView.SupplementaryRegistration<FooterView> {
        UICollectionView.SupplementaryRegistration<FooterView>(elementKind: UICollectionView.elementKindSectionFooter) {
            footer, string, indexPath in
            
            footer.viewNotificationCenter = notificationCenter
            footer.createOberservers()
            footer.label.text = "Reach the end of the line 🥳"
        }
    }
}
