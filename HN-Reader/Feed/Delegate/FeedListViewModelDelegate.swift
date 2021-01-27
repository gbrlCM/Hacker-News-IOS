//
//  FeedListViewModelDelegate.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

protocol FeedListViewModelDelegate {
    func reload(items: [Story])
    func append(items: [Story])
}
