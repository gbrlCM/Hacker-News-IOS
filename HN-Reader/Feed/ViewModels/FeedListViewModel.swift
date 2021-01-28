//
//  FeedListViewModel.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

struct FeedListViewModel {
    
    public let viewTitle: String
    private let section: FeedSection
    private let repository: FeedRepository = MockFeedRepository()
    private var page: Int = 0
    
    init(for section: FeedSection) {
        self.viewTitle = section.info.name
        self.section = section
    }
    
    public mutating func fetchNewData(receiveHandler: @escaping (_ feed: [Story]) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        page = 0
        repository.fetch(for: section, in: page, receiveHandler: { feed in
            receiveHandler(feed.data)
        } , sucessHandler: sucessHandler, failHandler: failHandler)
    }
    
    public mutating func fetchDataToAppend(receiveHandler: @escaping (_ feed: [Story]) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        page += 1
        repository.fetch(for: section, in: page, receiveHandler: { feed in receiveHandler(feed.data)}, sucessHandler: sucessHandler, failHandler: failHandler)
    }
}
