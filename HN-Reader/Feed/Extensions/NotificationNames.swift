//
//  NotificationNames.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 28/01/21.
//

import Foundation

extension NSNotification.Name {
    
    static var startedFetchingMoreData: NSNotification.Name {
        NSNotification.Name("startedFetchingMoreData")
    }
    
    static var endedFetchingMoreData: NSNotification.Name {
        NSNotification.Name("endedFetchingMoreData")
    }
    
    static var reachedTheEndOfTheLine: NSNotification.Name {
        NSNotification.Name("reachedTheEndOfTheLine")
    }
    
    static var resetFooter: NSNotification.Name {
        NSNotification.Name("resetFooter")
    }
}
