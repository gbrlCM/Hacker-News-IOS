//
//  SidebarViewModel.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 29/01/21.
//

import Foundation

struct SidebarViewModel {
    
    var sectionsData: [FeedSectionInfo] = []
    
    private mutating func generateList() {
        var items: [FeedSectionInfo] = []
        for section in FeedSection.allCases {
            items.append(section.info)
        }
        sectionsData = items
    }
    
    init() {
        generateList()
    }
    
}
