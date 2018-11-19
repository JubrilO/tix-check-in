//
//  HomeViewController.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, Storyboardable {
    var coordinator: EventsCoordinator?

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func onLogoutButtonTap(_ sender: UIButton) {
        
    }
    
}
