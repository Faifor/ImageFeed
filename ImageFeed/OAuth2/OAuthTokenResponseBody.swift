//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 06.08.2025.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
