//
//  CompactTabBarController.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

class FeedCompactTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        setupTabBarItems()
        setupTabBarStyle()
    }
    
    private func setupTabBarItems() {
        
        var viewControllers: [UIViewController] = []
        
        viewControllers.append(setupTabBarItem(for: .top, tag: 0))
        viewControllers.append(setupTabBarItem(for: .new, tag: 1))
        viewControllers.append(setupTabBarItem(for: .job, tag: 2))
        
        self.viewControllers = viewControllers
    }
    
    private func setupTabBarItem(for section: FeedSection, tag: Int) -> UINavigationController {
        let coordinator = CompactViewFeedCoordinator(for: section)
        coordinator.start()
        coordinator.navigationController.tabBarItem = UITabBarItem(title: section.info.name, image: UIImage(systemName: section.info.image), tag: tag)
        
        return coordinator.navigationController
    }
    
    private func setupTabBarStyle() {
        modalPresentationStyle = .fullScreen
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.accent],for: .selected)
        UITabBar.appearance().tintColor = .accent
    }
}
