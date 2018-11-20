//
//  CheckInViewController.swift
//  tix
//
//  Created by Jubril on 19/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController, Storyboardable {
    var coordinator: EventsCoordinator?
    var event: GetEventsQuery.Data.CurrentUser.Event.Edge.Node?
    var ticket: CheckInMutation.Data.CheckIn?
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ticketDetailLabel: UILabel!
    @IBOutlet weak var checkInTextField: TixTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
    }
    
    @IBAction func onCheckInButtonTap(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
