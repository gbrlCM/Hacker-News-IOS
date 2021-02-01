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
    private var feed: FeedViewController
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
        feed = FeedViewController(coordinator: coordinator, viewModel: FeedListViewModel(for: .new))
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        view.addSubview(splitView.view)
        
        splitView.view.translatesAutoresizingMaskIntoConstraints = false
        splitView.view.setFullScreenConstraint(to: view)
        
        splitView.setViewController(sidebar, for: .primary)
        splitView.setViewController(feed, for: .supplementary)
        splitView.setViewController(webView, for: .secondary)
        splitView.setViewController(compactView, for: .compact)
        splitView.preferredDisplayMode = .oneBesideSecondary
    }
}
