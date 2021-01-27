//
//  ViewControllerUtilities.swift
//  HN-Reader
//
//  Created by Gabriel Ferreira de Carvalho on 27/01/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: Child viewController
    func add(child viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeChild(){
        
        guard parent != nil else {return}
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
