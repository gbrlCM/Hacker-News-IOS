//
//  FeedListViewController.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

final class FeedViewController: UIViewController {
    
    //MARK: Views
    private var collectionView: UICollectionView
    private var refreshControl: UIRefreshControl
    private var eventsView: FeedEventsView
    
    //MARK: Variables
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, Story>
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Story>
    private var viewModel: FeedListViewModel
    
    //MARK: Inits
    init(coordinator: SplitViewCoordinator, viewModel: FeedListViewModel) {
        self.viewModel = viewModel
        collectionView = UICollectionView.createList(withStyle: .plain)
        cellRegistration = StoryCellRegistrationFactory.create()
        dataSource = StoryDataSourceFactory.create(for: collectionView, cellRegistration: cellRegistration)
        refreshControl = UIRefreshControl()
        eventsView = FeedEventsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let viewModel = coder.decodeObject(forKey: "viewModel") as? FeedListViewModel,
              let coordinator = coder.decodeObject(forKey: "SplitViewCoordinator") as? SplitViewCoordinator else { return nil}
        
        self.init(coordinator: coordinator, viewModel: viewModel)
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupRefreshControl()
        setupNavigationBar()
        setupEventsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = viewModel.viewTitle
    }
    
    //MARK: Views Setup
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView?.tintColor = .accent
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = .accent
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Stories")
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        collectionView.setFullScreenConstraint(to: view)
        
        collectionView.isHidden = true
    }
    
    private func setupEventsView() {
        view.addSubview(eventsView)
        eventsView.setFullScreenConstraint(to: view)
    }
    
    private func loadNewData() {
        
    }
    
    public func publish(data stories: [Story]) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, Story>()
        snapshot.appendSections([.main])
        snapshot.appendItems(stories)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    public func append(data stories: [Story]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(stories)
        
        dataSource.apply(snapshot)
    }
    
    //MARK: Actions
    @objc private func refreshData(_ sender: Any) {
        publish(data: [Story(storyIdentifier: 1, title: "OI", subtitle: "AAAAA", url: "PUDIM")])
    }
}
