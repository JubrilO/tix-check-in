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
   
//        let errorModal = ErrorModal()
//        let window = UIApplication.shared.keyWindow
//        let topPadding = window!.safeAreaInsets.top
//        let modalSize = CGSize(width: 63 + error.width(withConstrainedHeight: 14, font: errorModal.errorLabel.font), height: 40)
//        let x = (view.frame.size.width - modalSize.width)/2
//        errorModal.frame = CGRect(origin: CGPoint(x: x, y: -57 + topPadding), size: modalSize)
//        errorModal.errorLabel.text = error
//        view.addSubview(errorModal)
//        errorModal.alpha = 0
//        errorModal.animate(inParallel: [
//            .fadeIn(),
//            .move(byX: 0, y: 57 + topPadding)
//            ])
//
//        delay(3){
//            errorModal.animate(inParallel: [
//                .fadeOut(),
//                .move(byX: 0, y: -(57 + topPadding))
//                ]).perform {
//                    errorModal.removeFromSuperview()
//            }
//        }
        //    }}
        
    }
}
