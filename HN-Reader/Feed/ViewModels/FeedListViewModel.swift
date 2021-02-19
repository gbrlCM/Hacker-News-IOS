//
//  FeedListViewModel.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

final class FeedListViewModel {
    
    public let viewTitle: String
    private let section: FeedSection
    private var storyIds: [Int] = []
    private let repository: FeedRepository = FeedRepositoryNetwork()
    private var page: Int = 0
    public var dataQuantity: Int = 0
    
    init(for section: FeedSection) {
        self.viewTitle = section.info.name
        self.section = section
    }
    
    public func loadNewData(UIHandler: @escaping (Result<[Story], Error>) -> Void) {
        repository.initialFetch(for: section ) {[self] result in
            switch result {
            case .failure(let error):
                page = 0
                UIHandler(.failure(error))
            case .success(let feed):
                self.storyIds = feed.ids
                self.dataQuantity += feed.quantity
                UIHandler(.success(feed.data))
            }
        }
    }
    
    public func appendNewData(UIHandler: @escaping (Result<[Story], Error>) -> Void) {
        page += 1
        repository.fetch(for: section, in: page, ids: storyIds) {[self] result in
            switch result {
            case .failure(let error):
                page = 0
                UIHandler(.failure(error))
            case .success(let feed):
                self.dataQuantity += feed.quantity
                UIHandler(.success(feed.data))
            }
        }
    }
}
