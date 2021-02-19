//
//  MockFeedRepository.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import Combine

final class MockFeedRepository: FeedRepository {
    func fetch(for type: FeedSection, in page: Int, ids: [Int], completionHandler: @escaping (Result<Feed, Error>) -> Void) {
        
    }
    
    func initialFetch(for type: FeedSection, completionHandler: @escaping (Result<Feed, Error>) -> Void) {
        
    }
}

