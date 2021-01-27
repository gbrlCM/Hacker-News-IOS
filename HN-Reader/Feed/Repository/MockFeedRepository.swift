//
//  MockFeedRepository.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import Combine

final class MockFeedRepository: FeedRepository {
    
    private var cancellable = Set<AnyCancellable>()
    
    private func mock(for data: FeedSection) -> Data {
        switch data {
        case .new:
            return mockNewFeed
        case .job:
            return mockJobFeed
        case .top:
            return mockTopFeed
        }
    }
    
    func fetch(for type: FeedSection, in page: Int, receiveHandler: @escaping (Feed) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void) {
        
        Just(mock(for: type))
            .decode(type: Feed.self, decoder: JSONDecoder())
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                print(completion)
                self?.completionHandler(completion: completion, sucessHandler, failHandler)
            }, receiveValue: {
                data in
                receiveHandler(data)
            })
            .store(in: &cancellable)
    }
    
    private func completionHandler(completion: Subscribers.Completion<Error>, _ sucessHandler: @escaping () -> Void, _ failHandler: @escaping () -> Void) {
        switch completion {
            case .finished:
                sucessHandler()
            case .failure(_):
                failHandler()
        }
    }
}

