//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 06.08.2025.
//

import Foundation

final class OAuth2TokenStorage {
    private let userDefaults = UserDefaults.standard
    private let tokenKey = "bearerToken"
    
    var token: String? {
        get {
            userDefaults.string(forKey: tokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: tokenKey)
        }
    }
}
