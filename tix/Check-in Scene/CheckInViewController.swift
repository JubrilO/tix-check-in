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
    var ticket: CheckInMutation.Data.CheckIn?{
        didSet {
            setupUI()
        }
    }
    let loadingVC = LoadingViewController.instantiate()
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ticketDetailLabel: UILabel!
    @IBOutlet weak var checkInTextField: TixTextField!
    @IBOutlet weak var backToHomeLabel: UILabel!
    @IBOutlet weak var undoCheckInButton: UIButton!
    @IBOutlet weak var checkInButton: TixButton!
    @IBOutlet weak var wantToUndoButton: UIButton!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var wantToCheckInButton: UIButton!
    @IBOutlet weak var checkInQuestionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        coordinator?.popViewController(self)
    }
    
    @IBAction func onCheckInButtonTap(_ sender: UIButton) {
        showActivityIndicator()
        if  sender.titleLabel!.text == "Check In" {
            let amount = Int(checkInTextField.text!) ?? Int(checkInTextField.placeholder!) ?? 1
            coordinator?.checkInOrder(id: ticket!.id, amountToCheckIn: amount)
        }
        else {
            let amount = Int(checkInTextField.text!) ?? 1
            coordinator?.undoCheckIn(id: ticket!.id, amountToRemove: amount)
        }
    }
    
    @IBAction func onLogoutButtonTap(_ sender: UIButton) {
        coordinator?.logoutUser()
    }
    
    func setupUI() {
        guard eventNameLabel != nil else {
            return
        }
        eventNameLabel.text = event?.title
        orderIDLabel.text = "ORDER \(ticket!.shortId!)"
        emailLabel.text = ticket?.buyer
        ticketDetailLabel.text = "Paid for \(ticket!.quantity) * \(ticket!.ticket!.name!)"
        if ticket!.completelyCheckedIn {
            setupCompletelyCheckedInState()
        }
        else if ticket!.checkIns == 0 {
            setupNotCheckedInState()
        }
        else {
            setupPartialCheckInState()
        }
    }
    
    func setupCompletelyCheckedInState() {
        let dateUpdated = Date(timeIntervalSince1970: Double(ticket!.updatedAt))
        statusLabel.text = "Checked in \(dateUpdated.timeAgoSinceNow())"
        statusLabel.textColor = UIColor(red: 0.99, green: 0.39, blue: 0.21, alpha: 1)
        checkInTextField.isHidden = true
        checkInButton.isHidden = true
        wantToUndoButton.isHidden = true
        wantToCheckInButton.isHidden = true
        undoCheckInButton.isHidden = false
        checkInQuestionLabel.isHidden = true
        // Remeber to unhide when you setup count down timer.
        backToHomeLabel.isHidden = true
    }
    
    func setupNotCheckedInState() {
        statusLabel.text = "Not Checked In"
        statusLabel.textColor = .black
        wantToUndoButton.isHidden = true
        wantToCheckInButton.isHidden = true
        checkInQuestionLabel.text = "How many people to check in?"
        checkInQuestionLabel.isHidden = false
        checkInTextField.isHidden = false
        checkInButton.isHidden = false
        checkInButton.setTitle("Check In", for: .normal)
        backToHomeLabel.isHidden = true
        undoCheckInButton.isHidden = true
        checkInTextField.placeholder = String(ticket!.quantity)
        
    }
    
    func setupPartialCheckInState() {
        let dateUpdated = Date(timeIntervalSince1970: Double(ticket!.updatedAt))
        statusLabel.text = "\(ticket!.checkIns) of \(ticket!.quantity) checked in \(dateUpdated.timeAgoSinceNow())"
        statusLabel.textColor = .black
        wantToUndoButton.isHidden = false
        wantToCheckInButton.isHidden = true
        checkInButton.isHidden = false
        checkInButton.isHidden = false
        checkInButton.setTitle("Check In", for: .normal)
        backToHomeLabel.isEnabled = true
        undoCheckInButton.isHidden = true
        checkInQuestionLabel.isHidden = false
        checkInQuestionLabel.text = "How many people to check in?"
        checkInTextField.placeholder = String(ticket!.quantity - ticket!.checkIns)
    }
    
    @IBAction func onUndoCheckInButtonTap(_ sender: UIButton) {
        checkInQuestionLabel.isHidden = false
        checkInQuestionLabel.text = "How many check-ins to undo?"
        checkInButton.isHidden = false
        checkInTextField.isHidden = false
        checkInTextField.placeholder = String(ticket!.quantity)
        wantToCheckInButton.isHidden = false
        checkInButton.setTitle("Undo Check In", for: .normal)
        backToHomeLabel.isHidden = true
        sender.isHidden = true
    }
    
    
    @IBAction func onWantToUndoButtonTap(_ sender: UIButton) {
        checkInButton.setTitle("Undo Check In", for: .normal)
        checkInQuestionLabel.text = "How many check-ins to undo?"
        wantToCheckInButton.isHidden = false
        sender.isHidden = true
        
    }
    
    @IBAction func onWantToCheckInButtonTap(_ sender: UIButton) {
        checkInButton.setTitle("Check In", for: .normal)
        checkInQuestionLabel.text = "How many people to check in?"
        wantToUndoButton.isHidden = false
        sender.isHidden = true
        
    }
    
    func showActivityIndicator() {
        add(loadingVC)
        
    }
    
    func hideActivityIndicator() {
        loadingVC.remove()
    }
    
}
