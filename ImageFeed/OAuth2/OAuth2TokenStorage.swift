//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 06.08.2025.
//

import Foundation

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    private init() {}
    private let dataStorage = UserDefaults.standard
    private let tokenKey = "bearerToken"
    
    var token: String? {
        get {
            dataStorage.string(forKey: tokenKey)
        }
        set {
            if let token = newValue {
                dataStorage.set(token, forKey: tokenKey)
            } else {
                dataStorage.removeObject(forKey: tokenKey)
            }
        }
    }
}
