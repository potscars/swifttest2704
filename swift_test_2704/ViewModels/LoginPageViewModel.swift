//
//  LoginPageViewModel.swift
//  swift_test_2704
//
//  Created by owner on 28/04/2024.
//

import Foundation
import UIKit

class LoginPageViewModel {
    
    func validateLogin(with username: String, password: String, viewController: UIViewController) {
        let users = LocalDataManager.getDataFromFilepath()
        
        let filteredUser = users.filter { "\($0.firstName) \($0.lastName)" == username }
        
        if !filteredUser.isEmpty {
            StorageManager.shared.saveLoggedUser(user: filteredUser.first!)
            
            guard let homeTabbar = viewController.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as? HomeTabBarController else { return }
            homeTabbar.modalPresentationStyle = .fullScreen
            viewController.present(homeTabbar, animated: true)
        } else {
            print("User not found")
        }
    }
    
    func navigateToHomePage(viewController: UIViewController) {
        
        
    }
}
