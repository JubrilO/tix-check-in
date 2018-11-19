//
//  ViewController.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit
import SwiftValidator
import Locksmith

class LoginViewController: UIViewController, Storyboardable  {
    
    let validator = Validator()
    var coordinator: MainCoordinator?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidation()
    }
    
    func setupValidation() {
        validator.styleTransformers(success:{ (validationRule) -> Void in
            print("here")
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.green.withAlphaComponent(0.6).cgColor
                textField.layer.borderWidth = 0.5
                
            }
        }, error:{ (validationError) -> Void in
            print("error")
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        })
        validator.registerField(usernameTextField, rules: [EmailRule()])
        validator.registerField(passwordTextField, rules: [RequiredRule()])
    }
    
    @IBAction func onLoginButtonTap(_ sender: UIButton) {
        showActivityIndicator()
        validator.validate(self)
        
    }
    func showActivityIndicator() {
    activityIndicator.startAnimating()
    loginButton.setTitle("", for: .normal)
        loginButton.isEnabled = false
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = true
    }
    
    
}

extension LoginViewController: ValidationDelegate {
    
    func validationSuccessful() {
        coordinator?.signInUser(email: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        hideActivityIndicator()
        // <#code#>
    }
}


extension UIViewController {
    func displayErrorModal(error: String?, completionHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .default, handler: completionHandler)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
