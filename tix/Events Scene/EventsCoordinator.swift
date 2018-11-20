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
    
    func checkOrderID(id: Int) {
        let checkInMutation = CheckInMutation(amountToCheckIn: 0, shortID: id)
        ApolloManager().apolloClient.perform(mutation: checkInMutation) { [weak self]
            result, error in
            guard error == nil else {
                //hide activity inidcator
                self?.checkOrderVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            
            guard result?.errors == nil else {
                self?.checkOrderVC?.displayErrorModal(error: getGraphQLErrorString(result!.errors!))
                return
            }
            if let ticket = result?.data?.checkIn {
            self?.pushCheckInVC(ticket: ticket)
            }
        }
    }
    
    func checkOrderID(longID: String) {
        let checkInMutation = CheckInMutation(order: longID, amountToCheckIn: 0, shortID: nil)
        ApolloManager().apolloClient.perform(mutation: checkInMutation) { [weak self]
            result, error in
            print("request complete")
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
    
    func pushCheckInVC(ticket: CheckInMutation.Data.CheckIn) {
        let checkInVC = CheckInViewController.instantiate()
        self.checkInVC = checkInVC
        checkInVC.ticket = ticket
        checkInVC.coordinator = self
        checkInVC.event = currntEvent
        navigationController.pushViewController(checkInVC, animated: true)
    }
}
