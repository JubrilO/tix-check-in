//
//  Coordinator.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    //var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    
}
