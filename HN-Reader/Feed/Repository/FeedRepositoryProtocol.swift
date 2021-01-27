//
//  FeedRepository.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

protocol FeedRepository: AnyObject {
    
    func fetch(for type: FeedSection, in page: Int, receiveHandler: @escaping (_ feed: Feed) -> Void, sucessHandler: @escaping () -> Void, failHandler: @escaping () -> Void)
    
}
