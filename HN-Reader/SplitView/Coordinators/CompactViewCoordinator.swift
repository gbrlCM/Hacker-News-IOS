//
//  CompactViewCoordinator.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

final class CompactViewFeedCoordinator: SplitViewCoordinatorProtocol {
    
    var navigationController: UINavigationController
    private let section: FeedSection
    
    init(for section: FeedSection) {
        self.navigationController = UINavigationController()
        self.section = section
    }
    
    func start() {
        let viewModel = FeedListViewModel(for: section)
        let rootViewController = FeedViewController(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    func show(story urlRawValue: String) {
        navigationController.pushViewController(CompactWebViewController(url: URL(string: urlRawValue)!), animated: true)
    }
}
