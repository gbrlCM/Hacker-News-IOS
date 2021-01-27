//
//  ErrorLabel.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

import UIKit

final class ErrorLabel: UILabel {
    
    init(message: String) {
        super.init(frame: .zero)
        text = message
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
