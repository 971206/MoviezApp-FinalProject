//
//  UDManager.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import Foundation

class UDManager {
    
    // MARK: - Keys
    
    static let KEY_ONBOARDED              = "KEY_ONBOARDED"
    static let KEY_INTERESTS_IDS          = "KEY_INTERESTS_IDS"
    
    static var defaults: UserDefaults { UserDefaults.standard }
    
    // MARK: - Check if Onboarded
    
    static func markOnboarded() {
        UDManager.defaults.set(true, forKey: KEY_ONBOARDED)
    }
    
    static var isOnboarded: Bool {
        UDManager.defaults.bool(forKey: KEY_ONBOARDED)
    }
}
