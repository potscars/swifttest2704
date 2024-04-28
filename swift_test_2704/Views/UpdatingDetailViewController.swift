//
//  UpdatingDetailViewController.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation
import UIKit

class UpdatingDetailViewController: UIViewController {
    
    @IBOutlet private weak var mainHeaderLabel: UILabel!
    @IBOutlet private weak var subHeaderLabel: UILabel!
    
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    @IBOutlet private weak var firstnameLabel: UILabel!
    @IBOutlet private weak var firstnameTF: UITextField!
    
    @IBOutlet private weak var lastnameLabel: UILabel!
    @IBOutlet private weak var lastnameTF: UITextField!
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTF: UITextField!
    
    @IBOutlet private weak var contactLabel: UILabel!
    @IBOutlet private weak var contactTF: UITextField!
    
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var removeButton: UIButton!
    
    var vm: UpdateDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        guard let vm = vm else { return }
        
        if vm.detailType == .update {
            userImageView.isHidden = true
            
            imageLabel.text = (vm.firstname.first?.description ?? "") + (vm.lastname.first?.description ?? "")
            
            firstnameTF.text = vm.firstname
            lastnameTF.text = vm.lastname
            emailTF.text = vm.email
            contactTF.text = vm.phoneNumber
            
            saveButton.isHidden = true
            removeButton.isHidden = vm.isOwner()
        } else {
            imageLabel.isHidden = true
            
            updateButton.isHidden = true
            removeButton.isHidden = true
        }
        
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        imageContainerView.backgroundColor = UIColor(named: "PrimaryBlue")
        imageLabel.font = UIFont.systemFont(ofSize: 40)
        imageLabel.textColor = UIColor.white
        
        mainHeaderLabel.text = "Main information"
        mainHeaderLabel.textColor = UIColor(named: "PrimaryBlue")
        mainHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        subHeaderLabel.text = "Sub information"
        subHeaderLabel.textColor = UIColor(named: "PrimaryBlue")
        subHeaderLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        firstnameLabel.text = "Firstname"
        lastnameLabel.text = "Lastname"
        emailLabel.text = "Email"
        contactLabel.text = "Phone Number"
        
        firstnameTF.setUpImage(imageName: "person", on: .left)
        lastnameTF.setUpImage(imageName: "person", on: .left)
        contactTF.setUpImage(imageName: "person", on: .left)
        emailTF.setUpImage(imageName: "envelope", on: .left)
        
        removeButton.layer.borderColor = UIColor(named: "Red")?.cgColor
        removeButton.layer.borderWidth = 0.5
        
        [firstnameTF, lastnameTF, contactTF, emailTF].forEach { addBorder(to: $0) }
        [firstnameTF, lastnameTF, contactTF, emailTF].forEach { $0.delegate = self }
        
        saveButton.isEnabled = false
    }
    
    private func addBorder(to textField: UITextField) {
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(named: "PrimaryBlue")?.cgColor
    }
    
    @IBAction
    private func saveAction(_ sender: UIButton) {
        
        if let firstnameText = firstnameTF.text, let lastnameText = lastnameTF.text, let contactText = contactTF.text, let emailText = emailTF.text {
            let user = User(id: vm!.randomStringWithLength(len: 8) as String, firstName: firstnameText, lastName: lastnameText, email: emailText, phoneNumber: contactText)
            vm!.addUser(with: user)
            
            vm!.doneUpdateAndDismiss(viewController: self)
        }
    }
    
    @IBAction
    private func updateAction(_ sender: UIButton) {
        vm!.updateUser(with: firstnameTF.text, lastname: lastnameTF.text, email: emailTF.text, contact: contactTF.text)
        vm!.doneUpdateAndDismiss(viewController: self)
    }
    
    @IBAction
    private func removeAction(_ sender: UIButton) {
        vm!.removeUser()
        vm!.doneUpdateAndDismiss(viewController: self)
    }
    
    private func updateImageLabel() {
        let initialName = (firstnameTF.text?.first?.description ?? "") + (lastnameTF.text?.first?.description ?? "")
        imageLabel.text = initialName.uppercased()
    }
}

extension UpdatingDetailViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let vm = vm else { return }
        
        if vm.detailType == .add {
            if let firstnameText = firstnameTF.text, let lastnameText = lastnameTF.text, let contactText = contactTF.text, let emailText = emailTF.text {
                saveButton.isEnabled = !firstnameText.isEmpty && !lastnameText.isEmpty
            }
        }
        
        if textField == firstnameTF || textField == lastnameTF {
            self.updateImageLabel()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
