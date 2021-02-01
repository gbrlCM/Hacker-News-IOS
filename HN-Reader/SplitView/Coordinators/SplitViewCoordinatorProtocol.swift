//
//  SplitViewCoordinatorProtocol.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation

protocol SplitViewCoordinatorProtocol: Coordinator {
    
    func show(story urlRawValue: String)
}
