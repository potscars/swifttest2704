//
//  ProfilePageViewModel.swift
//  swift_test_2704
//
//  Created by owner on 28/04/2024.
//

import Foundation
import UIKit

class ProfilePageViewModel {
    
    var user: User?
    
    func fetchData() {
        if let loggedUser = StorageManager.shared.fetchLoggedUser() {
            user = loggedUser
        }
    }
    
    func navigateToUpdatePage(viewController: UIViewController) {
        guard let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "UpdatingDetailViewController") as? UpdatingDetailViewController else { return }
        vc.vm = UpdateDetailViewModel(type: .update, user: user!)
        
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logout(viewController: UIViewController) {
        
        guard let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "LoginPageViewController") as? LoginPageViewController else { return }
        
        StorageManager.shared.removeLoggedUser()
        
        viewController.view.window?.rootViewController = vc
        viewController.view.window?.makeKeyAndVisible()
    }
}
