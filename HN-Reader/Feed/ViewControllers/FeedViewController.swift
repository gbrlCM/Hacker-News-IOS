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
        setupRefreshControl()
        setupCollectionView()
        setupEventsView()
        setupNavigationBar()
        loadNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = viewModel.viewTitle
    }
    
    //MARK: Views Setup
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .accent
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.accent]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.accent]
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
        viewModel.fetchNewData {
            [weak self] feed in
            self?.publish(data: feed)
        } sucessHandler: {
            [weak self] in
            self?.handleSuccessFromFeedLoading()
        } failHandler: {
            [weak self] in
            self?.handleErrorFromFeedLoading()
        }
    }
    
    private func appendData() {
        viewModel.fetchDataToAppend {
            [weak self] feed in
            self?.append(data: feed)
        } sucessHandler: {
            [weak self] in
            self?.handleSuccessFromFeedLoading()
        } failHandler: {
            [weak self] in
            self?.handleErrorFromFeedLoading()
        }
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
    
    private func handleErrorFromFeedLoading() {
        collectionView.isHidden = true
        //MARK: REFACTOR!!!!
        eventsView.showError(message: "Failed to Load Resources")
        
        if eventsView.isLoading {
            eventsView.hideLoadingIndication()
        }
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    private func handleSuccessFromFeedLoading() {
        collectionView.isHidden = false
        
        if eventsView.isShowingError {
            eventsView.hideError()
        }
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        if eventsView.isLoading {
            eventsView.hideLoadingIndication()
        }
    }
    
    //MARK: Actions
    @objc private func refreshData(_ sender: Any) {
        loadNewData()
    }
}
