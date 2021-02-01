//
//  SplitViewCoordinator.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/21.
//

import Foundation
import UIKit

final class SplitViewCoordinator: SplitViewCoordinatorProtocol {
    
    private weak var webViewController: SplitViewWebViewController?
    
    init(webViewController: SplitViewWebViewController) {
        self.webViewController = webViewController
    }
    
    func start() {
        
    }
    
    func show(story urlRawValue: String) {
        
        guard let webView = webViewController else {
            return
        }
        webView.load(url: URL(string: urlRawValue)!)
    }
}
