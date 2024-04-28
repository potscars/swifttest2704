//
//  StorageManager.swift
//  swift_test_2704
//
//  Created by owner on 28/04/2024.
//

import Foundation

class StorageManager {
    private let defaults = UserDefaults.standard
  
    class var shared: StorageManager {
        struct Static {
            static let instance = StorageManager()
        }
      
        return Static.instance
    }
    
    func saveLoggedUser(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            defaults.set(data, forKey: TestKey.LOGGED_USER.desc)
        } catch {
            // If error. Here.
        }
    }
    
    func fetchLoggedUser() -> User? {
        
        guard let data = defaults.data(forKey: TestKey.LOGGED_USER.desc) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let person = try decoder.decode(User.self, from: data)
            return person
        } catch {
            // If error. Here.
            return nil
        }
    }
    
    func removeLoggedUser() {
        defaults.removeObject(forKey: TestKey.LOGGED_USER.desc)
    }
    
    func saveUserList(with users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)
            defaults.set(data, forKey: TestKey.LIST_USER.desc)
        } catch {
            // If error. Here.
        }
    }
    
    func fetchUserList() -> [User]? {
        guard let data = defaults.data(forKey: TestKey.LIST_USER.desc) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: data)
            return users
        } catch {
            // If error. Here.
            return nil
        }
    }
}

enum TestKey: String {
    case LOGGED_USER
    case LIST_USER
    
    var desc: String {
        self.rawValue
    }
}
