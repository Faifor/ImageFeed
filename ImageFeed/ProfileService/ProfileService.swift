//
//  Untitled.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 18.08.2025.
//

import Foundation

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
}

struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let bio: String?
    
    private enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}

final class ProfileService {
    static let shared = ProfileService()
    private init() {}
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private(set) var profile: Profile?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        task?.cancel()
        
        guard let request = makeProfileRequest(token: token) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let task = urlSession.data(for: request) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let profileResult = try JSONDecoder().decode(ProfileResult.self, from: data)
                    
                    let profile = Profile(
                        username: profileResult.username,
                        name: profileResult.firstName,
                        loginName: "@\(profileResult.username)",
                        bio: profileResult.bio
                    )
                    self?.profile = profile
                    completion(.success(profile))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            self?.task = nil
        }
        self.task = task
        task.resume()
    }
    
    private func makeProfileRequest(token: String) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/me") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

