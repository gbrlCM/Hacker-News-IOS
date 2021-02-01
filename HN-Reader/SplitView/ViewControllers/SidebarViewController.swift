//
//  SidebarViewController.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 29/01/21.
//

import Foundation
import UIKit

final class SidebarViewController: UIViewController {
    
    enum SidebarSection {
        case main
    }
    
    public var collectionView: UICollectionView
    private var dataSource: UICollectionViewDiffableDataSource<SidebarSection, FeedSectionInfo>
    private var factory: SidebarFactory
    private var viewModel: SidebarViewModel
    
    init() {
        factory = SidebarFactory()
        collectionView = factory.createCollectionView()
        dataSource = factory.createDataSource(for: collectionView)
        viewModel = SidebarViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.setFullScreenConstraint(to: view)
        appendSections()
        let indexPath = dataSource.indexPath(for: viewModel.sectionsData.first!)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        configurateNavigationController()
    }
    
    private func configurateNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Hacker News"
    }
    
    private func appendSections() {
    
        var snapshot = NSDiffableDataSourceSnapshot<SidebarSection, FeedSectionInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.sectionsData)
        dataSource.apply(snapshot)
        
    }
}
