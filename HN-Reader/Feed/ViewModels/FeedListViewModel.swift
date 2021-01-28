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
    private let repository: FeedRepository = MockFeedRepository()
    private var page: Int = 0
    public var dataQuantity: Int = 0
    
    init(for section: FeedSection) {
        self.viewTitle = section.info.name
        self.section = section
    }
    
    public func fetchNewData(receiveHandler: @escaping (_ feed: [Story]) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        page = 0
        repository.fetch(for: section, in: page, receiveHandler: { [weak self] feed in
            self?.page += 1
            self?.dataQuantity += feed.quantity
            receiveHandler(feed.data)
        } , sucessHandler: sucessHandler, failHandler: failHandler)
    }
    
    public func fetchDataToAppend(receiveHandler: @escaping (_ feed: [Story]) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        repository.fetch(for: section, in: page, receiveHandler: { feed in receiveHandler(feed.data)}, sucessHandler: sucessHandler, failHandler: failHandler)
        page += 1
    }
}
