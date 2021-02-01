//
//  SplitViewWebViewController.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/21.
//

import Foundation
import UIKit
import WebKit

final class SplitViewWebViewController: UIViewController {
    
    private var webView: WKWebView
    private var centralLabel: UILabel
    
    init() {
        webView = WKWebView(frame: .zero)
        centralLabel = UILabel(frame: .zero)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        centralLabel.textColor = .secondaryLabel
        
        view.addSubview(centralLabel)
        view.addSubview(webView)
        
        webView.isHidden = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        centralLabel.translatesAutoresizingMaskIntoConstraints = false
        
        centralLabel.anchorCenter(to: view)
        webView.setFullScreenConstraint(to: view)
        
        centralLabel.text = "Choose an article 🤯😬😱"
    }
    
    public func load(url: URL) {
        webView.isHidden = false
        centralLabel.isHidden = true
        webView.load(URLRequest(url: url))
    }
}
