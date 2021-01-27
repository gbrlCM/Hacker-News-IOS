//
//  Feed.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

struct Feed: Codable {
    var page: Int
    var quantity: Int
    var data: [Story]
}
