//
//  FeedSections.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

enum FeedSection: CaseIterable {
    
    static var allCases: [FeedSection] {
        return [.top, .new, .job]
    }
    
    case top
    case new
    case job
    
    var info: FeedSectionInfo {
        get {
            switch self {
                case .job:
                    return FeedSectionInfo(name: "Jobs", image: "case")
                case .new:
                    return FeedSectionInfo(name: "New", image: "newspaper")
                case .top:
                    return FeedSectionInfo(name: "Top", image: "flame")
            }
        }
    }
}
