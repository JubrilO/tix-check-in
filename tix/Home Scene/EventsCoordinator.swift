//
//  HomeCoordinator.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import Foundation
import UIKit

class EventsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    func start() {
        let eventsVC = EventsViewController.instantiate()
        eventsVC.coordinator = self
        navigationController.pushViewController(eventsVC, animated: true)
    }
    
    
    init(navVC: UINavigationController) {
        self.navigationController = navVC
    }
}
