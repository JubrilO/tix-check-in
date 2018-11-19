//
//  UIViewControllerExtensions.swift
//  Business
//
//  Created by Jubril on 11/13/18.
//  Copyright © 2018 Paystack. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func displayErrorModal(error: String) {
   
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
