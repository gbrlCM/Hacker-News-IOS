//
//  FeedViewController.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

final class DeprecatedFeedViewController: UIViewController {
    
    //private var feedController: FeedListViewController
    private var loadingActivityIndicator: UIActivityIndicatorView
    
    private let navigationTitle: String
    
    init(title: String, section: FeedSection, coordinator: SplitViewCoordinator) {
        //feedController = FeedListViewController(viewModel: FeedListViewModel(for: section))
        loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
        navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let title = coder.decodeObject(forKey: "title") as? String,
              let section = coder.decodeObject(forKey: "section") as? FeedSection,
              let coordinator = coder.decodeObject(forKey: "SplitViewCoordinator") as? SplitViewCoordinator else { return nil}
        
        self.init(title: title, section: section, coordinator: coordinator)
    }
    
    override func viewDidLoad() {
        //setupFeed()
        setupLoadingActivityIndicator()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = navigationTitle
    }
    
//    private func setupFeed() {
//        add(child: feedController)
//        feedController.view.setFullScreenConstraint(to: view)
//    }
    
    private func setupLoadingActivityIndicator() {
        view.addSubview(loadingActivityIndicator)
        loadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingActivityIndicator.anchorCenter(to: view)
        loadingActivityIndicator.hidesWhenStopped = true
        loadingActivityIndicator.startAnimating()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

