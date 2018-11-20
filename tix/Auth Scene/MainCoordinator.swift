//
//  MainCoordinator.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import Foundation
import UIKit
import Locksmith
import Apollo

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var loginVC: LoginViewController?
    
    init(navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        isUserAuthenticated() ? startEventsCoordinator(animated: false) : presentLoginScene()
    }
    
    func startEventsCoordinator(animated: Bool) {
        print("User is signed in")
        let eventsCoordinator = EventsCoordinator(navVC: navigationController)
        eventsCoordinator.start()

    }
    
    func presentLoginScene() {
        let loginVC = LoginViewController.instantiate()
        loginVC.coordinator = self
        self.loginVC = loginVC
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func signInUser(email: String, password: String) {
        let signInMutation = SignInMutation(email: email, password: password)
        print("Making call")
        ApolloManager().apolloClient.perform(mutation: signInMutation){ [weak self]
            result, error in
            print("Completed call")
            guard error == nil else {
                self?.loginVC?.hideActivityIndicator()
                self?.loginVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            guard result?.errors == nil else {
                self?.loginVC?.hideActivityIndicator()
                self?.loginVC?.displayErrorModal(error: getGraphQLErrorString(result!.errors!))
                return
            }
            guard let token = result?.data?.signIn?.authenticationToken else {
                self?.loginVC?.hideActivityIndicator()
                self?.loginVC?.displayErrorModal(error: "Could not retreive token")
                return
            }
            try! Locksmith.updateData(data: ["token" : token], forUserAccount: Constants.TixUser)
            self?.startEventsCoordinator(animated: true)
        }
    }
    
    private func isUserAuthenticated() -> Bool {
        if let _ = Locksmith.loadDataForUserAccount(userAccount: Constants.TixUser)?["token"] as? String{
            return true
        }
        else {
            return false
        }
    }
}

func getGraphQLErrorString(_ graphQLErrors: [GraphQLError]) -> String {
    var string = ""
    for graphQLError in graphQLErrors {
        string = string + graphQLError.localizedDescription + ". "
    }
    return string
}
