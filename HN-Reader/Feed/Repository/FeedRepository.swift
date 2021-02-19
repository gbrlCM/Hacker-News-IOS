//
//  FeedRepository.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/21.
//

import Foundation
import Combine

final class FeedRepositoryNetwork: FeedRepository {
    
    private var cancelable = Set<AnyCancellable>()
    
    func fetch(for type: FeedSection, in page: Int, ids: [Int], completionHandler: @escaping (Result<Feed, Error>) -> Void) {
        let data = try! JSONEncoder().encode(ids)
        URLSession.shared.dataTaskDecodedPublisher(for: .feed(for: type, at: page, data: data), decodeTo: Feed.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { (feed) in
                completionHandler(.success(feed))
            }.store(in: &cancelable)
    }
    
    func initialFetch(for type: FeedSection, completionHandler: @escaping (Result<Feed, Error>) -> Void) {
        URLSession.shared.dataTaskDecodedPublisher(for: .feed(for: type), decodeTo: Feed.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { (feed) in
                print(feed)
                completionHandler(.success(feed))
            }.store(in: &cancelable)
    }
    
}

fileprivate extension Endpoint {
    
    static func feed(for section: FeedSection, at page: Int, data: Data) -> Endpoint {
        var endpoint = Endpoint(to: "\(section.urlString)/\(page)", method: .post) {
            header in
            header.authorization = "Heroku"
            header.authorizationType = .bearer
            header.contentType = .json
        }
        endpoint.data = data
        return endpoint
    }
    
    static func feed(for section: FeedSection) -> Endpoint {
        return Endpoint(to: "\(section.urlString)", method: .get) {
            header in
            header.authorization = "Heroku"
            header.authorizationType = .bearer
            header.contentType = .json
        }
    }
}

private extension FeedSection {
    
    var urlString: String {
        get {
            switch self {
            case .job:
                return "feed/jobstories"
            case .new:
                return "feed/newstories"
            case .top:
                return "feed/topstories"
            }
        }
    }
}
