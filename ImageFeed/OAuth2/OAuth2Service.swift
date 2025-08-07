//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 05.08.2025.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    
    private let tokenStorage = OAuth2TokenStorage()
    private let decoder = JSONDecoder()
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            return nil
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]

        guard let authTokenUrl = urlComponents.url else {
            return nil
        }

        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Network error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.urlRequestError(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No HTTP response")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.urlSessionError))
                }
                return
            }
            
            let statusCode = httpResponse.statusCode
            guard (200..<300).contains(statusCode) else {
                print("Bad HTTP status code: \(statusCode)")
                if let data = data, let errorText = String(data: data, encoding: .utf8) {
                    print("Error body: \(errorText)")
                }
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
                return
            }
            
            guard let data = data else {
                print("Empty response data")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.urlSessionError))
                }
                return
            }
            
            do {
                let tokenResponse = try self.decoder.decode(OAuthTokenResponseBody.self, from: data)
                let token = tokenResponse.accessToken
                self.tokenStorage.token = token
                print("Access token received: \(token)")
                
                DispatchQueue.main.async {
                    completion(.success(token))
                }
            } catch {
                print("Decoding error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
}

