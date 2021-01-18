//
//  ActivityEndpoint.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

import Foundation

final class ActivityEndpoint {
    enum Error: Swift.Error {
        case invalidResponse
        case invalidData
        case invalidInitialData
    }
    
    private let authModel: Oauth2Model?
    
    init(authModel: Oauth2Model?) {
        self.authModel = authModel
    }
}

extension ActivityEndpoint: ActivityProviding {
    func getActivity(for userName: String, completion: @escaping (Result<[ActivityEntity], Swift.Error>) -> Void) {
        guard
            let base = URL(string: "https://api.github.com/users/"),
            let model = authModel?.oauth2
        else {
            completion(.failure(Error.invalidInitialData))
            return
        }
        let url = base.appendingPathComponent(userName).appendingPathComponent("/received_events")
        let request = model.request(forURL: url)
        let task = model.session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(Error.invalidData))
                return
            }
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                completion(.failure(Error.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(Error.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode([ActivityEntity].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(Error.invalidData))
            }
        }
        task.resume()
    }
}
