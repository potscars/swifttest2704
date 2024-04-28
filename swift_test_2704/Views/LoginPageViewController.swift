//
//  LoginPageViewController.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var subHeaderLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    
    @IBOutlet private weak var usernameTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    private let vm = LoginPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    private func setupView() {
        headerLabel.text = "Hi There!"
        headerLabel.textColor = UIColor(named: "PrimaryBlue")
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        subHeaderLabel.text = "Please login to see your contact list"
        subHeaderLabel.textColor = UIColor(named: "DarkGray")
        subHeaderLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        usernameLabel.text = "Username"
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = UIColor.black
        passwordLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        usernameTF.backgroundColor = UIColor(named: "White")
        usernameTF.setUpImage(imageName: "person", on: .left)
        usernameTF.layer.borderWidth = 0.5
        usernameTF.layer.borderColor = UIColor(named: "PrimaryBlue")?.cgColor
        
        passwordTF.isSecureTextEntry = true
        passwordTF.backgroundColor = UIColor(named: "White")
        passwordTF.setUpImage(imageName: "envelope", on: .left)
        passwordTF.layer.borderWidth = 0.5
        passwordTF.layer.borderColor = UIColor(named: "PrimaryBlue")?.cgColor
        
        usernameTF.delegate = self
        passwordTF.delegate = self
        
        loginButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.navigateToHomePage(viewController: self)
    }
    
    @IBAction
    private func loginAction(_ sender: UIButton) {
        if let usernameText = usernameTF.text, let passwordText = passwordTF.text {
            vm.validateLogin(with: usernameText, password: passwordText, viewController: self)
        }
    }
}

extension LoginPageViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let usernameText = usernameTF.text, let passwordText = passwordTF.text {
            loginButton.isEnabled = !usernameText.isEmpty && !passwordText.isEmpty
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

