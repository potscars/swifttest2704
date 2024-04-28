//
//  UpdateDetailViewModel.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation
import UIKit

class UpdateDetailViewModel {
    
    private var type: DetailType
    private var user: User?
    
    init(type: DetailType, user: User?) {
        self.type = type
        self.user = user
    }
    
    var detailType: DetailType {
        type
    }
    
    var firstname: String {
        user?.firstName ?? ""
    }
    
    var lastname: String {
        user?.lastName ?? ""
    }
    
    var email: String {
        user?.email ?? ""
    }
    
    var dob: String {
        user?.dob ?? ""
    }
    
    var phoneNumber: String {
        user?.phoneNumber ?? ""
    }
    
    func isOwner() -> Bool {
        if let loggedUser = StorageManager.shared.fetchLoggedUser() {
            return loggedUser.id == user!.id
        }
        
        return false
    }
    
    func addUser(with user: User) {
        var users = StorageManager.shared.fetchUserList()
        users?.append(user)
        StorageManager.shared.saveUserList(with: users ?? [user])
    }
    
    func updateUser(with firstname: String?, lastname: String?, email: String?, contact: String?) {
        guard var users = StorageManager.shared.fetchUserList() else {
            return
        }
        
        if let row = users.firstIndex(where: {$0.id == user!.id}) {
            users[row] = User(id: user!.id, firstName: firstname ?? user!.firstName, lastName: lastname ?? user!.lastName, dob: user!.dob, email: email, phoneNumber: contact)
        }
        
        if isOwner() {
           let tempUser = User(id: user!.id, firstName: firstname ?? user!.firstName, lastName: lastname ?? user!.lastName, dob: user!.dob, email: email, phoneNumber: contact)
            StorageManager.shared.saveLoggedUser(user: tempUser)
        }
        
        StorageManager.shared.saveUserList(with: users)
    }
    
    func removeUser() {
        guard var users = StorageManager.shared.fetchUserList() else {
            return
        }
        
        if let row = users.firstIndex(where: {$0.id == user!.id}) {
            users.remove(at: row)
        }
        
        StorageManager.shared.saveUserList(with: users)
    }
    
    func doneUpdateAndDismiss(viewController: UIViewController) {
        NotificationCenter.default.post(name: .didUpdateUserList, object: nil)
        viewController.navigationController?.popViewController(animated: true)
    }
 
    func randomStringWithLength(len: Int) -> NSString {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        let randomString : NSMutableString = NSMutableString(capacity: len)

        for _ in 1...len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }

        return randomString
    }
}

enum DetailType {
    case update, add
}
