//
//  ObservableObject.swift
//  KornApps
//
//  Created by owner on 26/01/2023.
//

import Foundation

// Used for binding the mvvm variable.
// Listeners are in array because if multiple variable connects to the listener.
class ObservableObject<T> {
    
    var value: T? {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    private var listeners: [((T?) -> ())] = []
    
    func bind(_ listener: @escaping (T?) -> ()) {
        listener(value)
        self.listeners.append(listener)
    }
}
