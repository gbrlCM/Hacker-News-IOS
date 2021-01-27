//
//  CoordinatorProtocol.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController {get set}
    func start()
}

