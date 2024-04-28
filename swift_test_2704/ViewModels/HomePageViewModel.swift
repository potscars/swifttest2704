//
//  HomePageViewModel.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation

class HomePageViewModel {
    
    var users: ObservableObject<[User]> = ObservableObject([])
    var usersGroup: [String: [User]] = [:]
    var groupLetters: [String] = []
    
    func fetchUsers() {
        
        let tempUsers = LocalDataManager.getDataFromFilepath()
        
        users.value = tempUsers
        
        guard !tempUsers.isEmpty else { return }
        
        let groups = Dictionary(grouping: tempUsers, by: { String($0.firstName.first!).uppercased() })
        
        // Create an array for sections
        for (key, _) in groups {
            groupLetters.append(key)
        }
        
        // Sorted and remove duplicates.
        groupLetters = Array(Set(groupLetters)).sorted(by: <)
        
        usersGroup = groups
    }
}
