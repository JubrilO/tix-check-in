//
//  HomeCoordinator.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import Foundation
import UIKit
import Locksmith

class EventsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var checkOrderVC: CheckOrderViewController?
    var checkInVC: CheckInViewController?
    var currntEvent: GetEventsQuery.Data.CurrentUser.Event.Edge.Node?
    
    func start() {
        let eventsVC = EventsViewController.instantiate()
        eventsVC.coordinator = self
        navigationController.pushViewController(eventsVC, animated: true)
    }
    
    
    init(navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func popViewController(_ vc: UIViewController) {
        navigationController.popViewController(animated: true)
    }
    
    func pushCheckOrderScene(event: GetEventsQuery.Data.CurrentUser.Event.Edge.Node) {
        let checkOrderVC = CheckOrderViewController.instantiate()
        currntEvent = event
        checkOrderVC.coordinator = self
        checkOrderVC.event = event
        self.checkOrderVC = checkOrderVC
        navigationController.pushViewController(checkOrderVC, animated: true)
    }
    
    func checkOrderID(id: String) {
        let checkInMutation = CheckInMutation(amountToCheckIn: 0, shortID: id)
        ApolloManager().apolloClient.perform(mutation: checkInMutation) { [weak self]
            result, error in
            self?.checkOrderVC?.hideActivityIndicator()
            guard error == nil else {
                //hide activity inidcator
                self?.checkOrderVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            
            guard result?.errors == nil else {
                self?.checkOrderVC?.displayErrorModal(error: getGraphQLErrorString(result!.errors!))
                return
            }
            print(result?.data?.checkIn)
            if let ticket = result?.data?.checkIn {
            self?.pushCheckInVC(ticket: ticket)
            }
            //self?.pushCheckInVC(ticket: result?.data?.checkIn!)
        }
    }
    
    func checkOrderID(longID: String) {
        let checkInMutation = CheckInMutation(order: longID, amountToCheckIn: 0)
        ApolloManager().apolloClient.perform(mutation: checkInMutation) { [weak self]
            result, error in
            print("request complete")
            self?.checkOrderVC?.hideActivityIndicator()
            guard error == nil else {
                //hide activity inidcator
                self?.checkOrderVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            
            guard result?.errors == nil else {
                print(result?.errors)
                self?.checkOrderVC?.displayErrorModal(error: getGraphQLErrorString(result!.errors!))
                return
            }
            if let ticket = result?.data?.checkIn {
                self?.pushCheckInVC(ticket: ticket)
            }
        }
    }
    
    func checkInOrder(id: String, amountToCheckIn: Int) {
        let checkInMutation = CheckInMutation(order: id, amountToCheckIn: amountToCheckIn)
        ApolloManager().apolloClient.perform(mutation: checkInMutation) { [weak self]
            result, error in
            print("request complete")
            self?.checkInVC?.hideActivityIndicator()
            guard error == nil else {
                self?.checkInVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            
            guard result?.errors == nil else {
                self?.checkInVC?.displayErrorModal(error: getGraphQLErrorString(result!.errors!))
                return
            }
            if let ticket = result?.data?.checkIn {
                self?.checkInVC?.ticket = ticket
            }
        }
    }
    
    func undoCheckIn(id: String, amountToRemove: Int) {
        let undoCheckInMutation = UndoCheckInMutation(id: id, amountToRemove: amountToRemove)
        ApolloManager().apolloClient.perform(mutation: undoCheckInMutation) { [weak self]
            result, error in
            print("request complete")
            self?.checkInVC?.hideActivityIndicator()
            guard error == nil else {
                self?.checkInVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            
            guard result?.errors == nil else {
                self?.checkInVC?.displayErrorModal(error: getGraphQLErrorString(result!.errors!))
                return
            }
            if let ticket = result?.data?.undoCheckIn {
                
                let tick = CheckInMutation.Data.CheckIn(id: ticket.id, buyer: ticket.buyer, checkIns: ticket.checkIns, completelyCheckedIn: ticket.completelyCheckedIn, qrCode: ticket.qrCode, quantity: ticket.quantity, shortId: ticket.shortId, status: ticket.status, updatedAt: ticket.updatedAt, ticket: CheckInMutation.Data.CheckIn.Ticket(name: ticket.ticket?.name))
                self?.checkInVC?.ticket = tick
            }
        }
        
    }
    
    func logoutUser() {
        try! Locksmith.deleteDataForUserAccount(userAccount: Constants.TixUser)
        MainCoordinator(navVC: navigationController).start()
    }
    
    func pushCheckInVC(ticket: CheckInMutation.Data.CheckIn) {
        let checkInVC = CheckInViewController.instantiate()
        self.checkInVC = checkInVC
        checkInVC.ticket = ticket
        checkInVC.coordinator = self
        checkInVC.event = currntEvent
        navigationController.pushViewController(checkInVC, animated: true)
    }
}
