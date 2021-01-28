//
//  CollectionViewFooter.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 28/01/21.
//

import Foundation
import UIKit

final class FooterView: UICollectionReusableView {
    
    override var reuseIdentifier: String? {
        String(describing: self)
    }
    
    public var loadingIndication: UIActivityIndicatorView
    public var label: UILabel
    weak public var viewNotificationCenter: NotificationCenter?
    
    override init(frame: CGRect) {
        label = UILabel.init(frame: .zero)
        loadingIndication = UIActivityIndicatorView(style: .medium)
        super.init(frame: frame)
        
        loadingIndication.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingIndication)
        loadingIndication.anchorCenter(to: self)
        loadingIndication.hidesWhenStopped = true
        loadingIndication.color = .accent
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.anchorCenter(to: self)
        label.isHidden = true
        label.textColor = .accent
    }
    
    required convenience init?(coder: NSCoder) {
        guard let frame = coder.decodeObject(forKey: "frame") as? CGRect else { return nil }
        self.init(frame: frame)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        handleDenitializationOfObservers()
    }
    
    deinit {
        handleDenitializationOfObservers()
    }
    
   public func createOberservers() {
        guard let notificationCenter = viewNotificationCenter else { return }
        
        notificationCenter.addObserver(self, selector: #selector(showLoadingIndication(notification:)), name: .startedFetchingMoreData, object: nil)
        notificationCenter.addObserver(self, selector: #selector(hideLoadingIndication(notification:)), name: .endedFetchingMoreData, object: nil)
        notificationCenter.addObserver(self, selector: #selector(showEndOfTheLineLabel(notification:)), name: .reachedTheEndOfTheLine, object: nil)
        notificationCenter.addObserver(self, selector: #selector(resetView(notification:)), name: .resetFooter, object: nil)
    }
    
    @objc func showLoadingIndication(notification: NSNotification) {
        loadingIndication.startAnimating()
    }
    
    @objc func hideLoadingIndication(notification: NSNotification) {
        loadingIndication.stopAnimating()
    }
    
    @objc func showEndOfTheLineLabel(notification: NSNotification) {
        print("ooooi")
        label.isHidden = false
        loadingIndication.stopAnimating()
    }
    
    @objc func resetView(notification: NSNotification) {
        label.isHidden = true
        loadingIndication.stopAnimating()
    }
    
    func handleDenitializationOfObservers() {
        guard let notificationCenter = viewNotificationCenter else {
            return
        }
        
        notificationCenter.removeObserver(self, name: .startedFetchingMoreData, object: nil)
        notificationCenter.removeObserver(self, name: .endedFetchingMoreData, object: nil)
        notificationCenter.removeObserver(self, name: .reachedTheEndOfTheLine, object: nil)
        notificationCenter.removeObserver(self, name: .resetFooter, object: nil)
        
        viewNotificationCenter = nil
    }
    
}


