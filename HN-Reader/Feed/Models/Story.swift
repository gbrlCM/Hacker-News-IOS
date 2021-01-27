//
//  Story.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

struct Story: Codable, Hashable {
    var storyIdentifier: Int
    var title: String
    var subtitle: String
    var url: String
}
