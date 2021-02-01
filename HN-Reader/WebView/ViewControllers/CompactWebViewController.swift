//
//  WebViewController.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 28/01/21.
//

import Foundation
import UIKit
import WebKit

final class CompactWebViewController: UIViewController {
    
    var webView: WKWebView
    var viewURL: URL
    
    init(url: URL) {
        webView = WKWebView()
        viewURL = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let url = coder.decodeObject(forKey: "url") as? URL else { return nil }
        self.init(url: url)
    }
    
    override func loadView() {
        view = webView
        webView.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: viewURL))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension CompactWebViewController: WKNavigationDelegate {
    
}
