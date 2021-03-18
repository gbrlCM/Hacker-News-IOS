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
    private var loadingFlag: Bool = false
    
    //MARK: Variables
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, Story>
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Story>
    private var footerRegistration: UICollectionView.SupplementaryRegistration<FooterView>
    private var viewModel: FeedListViewModel
    private var notificationCenter: NotificationCenter
    private var coordinator: SplitViewCoordinatorProtocol
    
    //MARK: Inits
    init(coordinator: SplitViewCoordinatorProtocol, viewModel: FeedListViewModel, appearence: UICollectionLayoutListConfiguration.Appearance) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        notificationCenter = NotificationCenter()
        collectionView = UICollectionView.createList(withStyle: appearence)
        cellRegistration = StoryCellRegistrationFactory.create()
        footerRegistration = StoryHeaderRegistrationFactory.create(notificationCenter: notificationCenter)
        dataSource = StoryDataSourceFactory.create(for: collectionView, cellRegistration: cellRegistration)
        refreshControl = UIRefreshControl()
        eventsView = FeedEventsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let viewModel = coder.decodeObject(forKey: "viewModel") as? FeedListViewModel,
              let coordinator = coder.decodeObject(forKey: "SplitViewCoordinator") as? SplitViewCoordinatorProtocol else { return nil}
        
        self.init(coordinator: coordinator, viewModel: viewModel, appearence: .plain)
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupRefreshControl()
        setupCollectionView()
        setupEventsView()
        setupNavigationBar()
        viewReactTo(state: .loadingInitialStories)
        loadNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = viewModel.viewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: Views Setup
    private func setupNavigationBar() {
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
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.isHidden = true
        dataSource.supplementaryViewProvider = {[unowned self] view, elementKind, indexPath in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
        }
        
    }
    
    private func setupEventsView() {
        view.addSubview(eventsView)
        eventsView.setFullScreenConstraint(to: view)
    }
    
    //MARK: Data fetching view handling
    
    private func loadNewData() {
        post(notification: .resetFooter)
        viewModel.loadNewData { [self] result in
            switch result {
            case .failure(_):
                viewReactTo(state: .errorFetchingInitialStories)
            case .success(let feed):
                publish(data: feed)
                viewReactTo(state: .loadedInitialStories)
            }
        }
    }
    
    private func appendData() {
        loadingFlag = true
        post(notification: .startedFetchingMoreData)
        viewModel.appendNewData {[self] result in
            switch result {
            case .failure(_):
                viewReactTo(state: .errorFetchingNewStories)
            case .success(let feed):
                append(data: feed)
                handleFinishLoadingPost(stories: feed)
            }
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
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: Actions
    @objc private func refreshData(_ sender: Any) {
        loadNewData()
    }
}

//MARK: Delegate
extension FeedViewController: UICollectionViewDelegate {
    
    private func isEligibleForDataFetching(_ scrollView: UIScrollView) -> Bool {
        
        let scrollViewYoffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewFrameHeight = scrollView.frame.size.height
        
        let didReachTheEnd = scrollViewYoffset > contentHeight - scrollViewFrameHeight
        let isNotFirstScreenInitialization = dataSource.numberOfSections(in: collectionView) > 0
        
        return didReachTheEnd && isNotFirstScreenInitialization && !loadingFlag
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isEligibleForDataFetching(scrollView){
            appendData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        coordinator.show(story: item.url)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: Observers
extension FeedViewController {
    
    func post(notification name: NSNotification.Name) {
        notificationCenter.post(name: name, object: nil)
    }
    
    func handleFinishLoadingPost(stories: [Story]) {
        if stories == [] {
            viewReactTo(state: .noMoreStoriesAvailable)
        }
        else {
            viewReactTo(state: .loadedNewStories)
            loadingFlag = false
        }
    }
}

//MARK: State handling
extension FeedViewController {
    
    enum ViewState {
        case loadingNewStories
        case loadedNewStories
        case loadingInitialStories
        case loadedInitialStories
        case noMoreStoriesAvailable
        case errorFetchingInitialStories
        case errorFetchingNewStories
    }
    
    func viewReactTo(state: ViewState) {
        switch state {
        case .loadingNewStories:
            refreshControl.beginRefreshing()
            
        case .loadedNewStories:
            refreshControl.endRefreshing()
            post(notification: .endedFetchingMoreData)
            
        case .loadingInitialStories:
            eventsView.showLoadingIndication()
            
        case .loadedInitialStories:
            collectionView.isHidden = false
            eventsView.hideError()
            eventsView.hideLoadingIndication()
            refreshControl.endRefreshing()
            
        case .noMoreStoriesAvailable:
            post(notification: .reachedTheEndOfTheLine)
            
        case .errorFetchingNewStories:
            collectionView.isHidden = true
            eventsView.showError(message: "Failed to Load Resources")
            
        case .errorFetchingInitialStories:
            collectionView.isHidden = true
            eventsView.showError(message: "Failed to Load Resources")
            eventsView.hideLoadingIndication()
        }
    }
}
