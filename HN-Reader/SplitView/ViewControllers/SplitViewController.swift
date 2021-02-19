//
//  File.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 29/01/21.
//

import Foundation
import UIKit

final class SplitViewController: UIViewController {
    
    private var splitView: UISplitViewController
    private var feed: [FeedSection:FeedViewController] = [:]
    private var coordinator: SplitViewCoordinator
    private var sidebar: SidebarViewController
    private var webView: SplitViewWebViewController
    private var compactView: FeedCompactTabBarController
    
    init() {
        splitView = UISplitViewController(style: .tripleColumn)
        sidebar = SidebarViewController()
        compactView = FeedCompactTabBarController()
        webView = SplitViewWebViewController()
        coordinator = SplitViewCoordinator(webViewController: webView)
        super.init(nibName: nil, bundle: nil)
        feed = FeedSection.allCases.reduce(into: [FeedSection : FeedViewController]()) {
            result, section in
            result[section] = FeedViewController(coordinator: coordinator, viewModel: FeedListViewModel(for: section), appearence: .sidebarPlain)
        }
        sidebar.collectionView.delegate = self
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        view.addSubview(splitView.view)
        
        splitView.view.translatesAutoresizingMaskIntoConstraints = false
        splitView.view.setFullScreenConstraint(to: view)
        
        splitView.setViewController(sidebar, for: .primary)
        splitView.setViewController(feed[FeedSection.allCases.first!], for: .supplementary)
        splitView.setViewController(webView, for: .secondary)
        splitView.setViewController(compactView, for: .compact)
        splitView.preferredDisplayMode = .oneBesideSecondary
    }
}

extension SplitViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let section = sidebar.getIdentifier(at: indexPath) else { return }
        splitView.setViewController(feed[section], for: .supplementary)
        
    }
}
