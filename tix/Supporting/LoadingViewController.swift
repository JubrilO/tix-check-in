//
//  LoginViewController.swift
//  tix
//
//  Created by Jubril on 21/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, Storyboardable {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.alpha = 0
        view.animate(.fadeIn())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.animate(.fadeOut())
    }

}
