//
//  FeedEventsView.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

final class FeedEventsView: UIView {
    
    private var errorLabel: UILabel
    private var loadingIndicator: UIActivityIndicatorView
    
    
    init() {
        errorLabel = UILabel()
        loadingIndicator = UIActivityIndicatorView(style: .large)
        
        super.init(frame: .zero)
        
        setupErrorLabel()
        setupLoadingIndicator()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    private func setupErrorLabel() {
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.anchorCenter(to: self)
        errorLabel.textColor = .secondaryLabel
        errorLabel.isHidden = true
    }
    
    private func setupLoadingIndicator() {
        addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.anchorCenter(to: self)
        loadingIndicator.color = .accent
        loadingIndicator.hidesWhenStopped = true
    }
    
    public func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    public func hideError() {
        errorLabel.isHidden = true
    }
    
    public func showLoadingIndication() {
        loadingIndicator.startAnimating()
    }
    
    public func showHidingIndication() {
        loadingIndicator.stopAnimating()
    }
}
