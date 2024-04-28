//
//  ProfilePageViewController.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation
import UIKit

class ProfilePageViewController: UIViewController {
    
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageLabel: UILabel!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var bodLabel: UILabel!
    
    private let vm = ProfilePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.updateData()
        self.setupObserver()
    }
    
    private func setupView() {
        
        title = "My Profile"
        
        let logOutButton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logoutAction))
        self.navigationItem.rightBarButtonItem = logOutButton
        
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        imageContainerView.backgroundColor = UIColor(named: "PrimaryBlue")
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: .didUpdateUserList, object: nil)
    }
    
    @objc
    private func updateData() {
        self.vm.fetchData()
        self.loadData()
    }
    
    private func loadData() {
        guard let user = vm.user else { return }
        
        let initialName: String = (user.firstName.first?.description ?? "") + (user.lastName.first?.description ?? "")
        
        imageLabel.text = initialName
        imageLabel.font = UIFont.systemFont(ofSize: 40)
        imageLabel.textColor = UIColor.white
        
        commonLabelConfig(label: nameLabel, with: user.firstName + " " + user.lastName)
        commonLabelConfig(label: emailLabel, with: user.email ?? "N/A")
        commonLabelConfig(label: bodLabel, with: user.dob ?? "N/A")
    }
    
    private func commonLabelConfig(label: UILabel, with value: String) {
        label.text = value
        label.textColor = UIColor(named: "DarkGray")
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    @IBAction
    private func updateAction(_ sender: UIButton) {
        vm.navigateToUpdatePage(viewController: self)
    }
    
    @objc
    private func logoutAction() {
        vm.logout(viewController: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didUpdateUserList, object: nil)
    }
}
