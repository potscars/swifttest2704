//
//  LocalDataManager.swift
//  swift_test_2704
//
//  Created by owner on 28/04/2024.
//

import Foundation

class LocalDataManager {
    
    static func getDataFromFilepath() -> [User] {
        
        if let users = StorageManager.shared.fetchUserList(), users.count > 0 {
            
            return users.sorted { "\($0.firstName) \($0.lastName)" <  "\($1.firstName) \($1.lastName)" }

        } else {
            
            guard let path = Bundle.main.path(forResource: "user", ofType: "json") else {
                return []
            }
            
            let url = URL(fileURLWithPath: path)
            
            do {
                
                let data = try Data(contentsOf: url)
                let users = try JSONDecoder().decode([User].self, from: data)
                StorageManager.shared.saveUserList(with: users)
                return users.sorted { "\($0.firstName) \($0.lastName)" <  "\($1.firstName) \($1.lastName)" }
                
            } catch {
                print(error)
                
                return []
            }
        }
    }
}
