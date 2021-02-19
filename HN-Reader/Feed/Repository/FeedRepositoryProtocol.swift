//
//  FeedRepository.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

protocol FeedRepository: AnyObject {
    
    func fetch(for type: FeedSection, in page: Int, ids: [Int], completionHandler: @escaping (Result<Feed, Error>) -> Void)
    func initialFetch(for type: FeedSection, completionHandler: @escaping (Result<Feed, Error>) -> Void)
}

