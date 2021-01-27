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
    
    init(for section: FeedSection) {
        self.viewTitle = section.info.name
        self.section = section
    }
    
    public func fetchNewData(receiveHandler: @escaping (_ feed: [Story]) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        
    }
    
    public func fetchDataToAppend(receiveHandler: @escaping (_ feed: [Story]) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        
    }
}
