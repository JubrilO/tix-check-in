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
        apolloClient.perform(mutation: signInMutation){ [weak self]
            result, error in
            print("Completed call")
            guard error == nil else {
                self?.loginVC?.hideActivityIndicator()
                self?.loginVC?.displayErrorModal(error: error?.localizedDescription)
                return
            }
            guard result?.errors == nil else {
                var string = ""
                for graphQLError in result!.errors! {
                     string = string + graphQLError.localizedDescription + ". "
                }
                self?.loginVC?.hideActivityIndicator()
                self?.loginVC?.displayErrorModal(error: string)
                return
            }
            guard let token = result?.data?.signIn?.authenticationToken else {
                return
            }
            try! Locksmith.updateData(data: ["token" : token], forUserAccount: Constants.TixUser)
            self?.startEventsCoordinator(animated: true)
        }
    }
    
    private func isUserAuthenticated() -> Bool {
        if let tokenDict = Locksmith.loadDataForUserAccount(userAccount: Constants.TixUser) {
            guard let _ = tokenDict["token"] as? String else {
                return true
            }
            return false
            
        }
        else {
            return false
        }
    }
    
    
}
