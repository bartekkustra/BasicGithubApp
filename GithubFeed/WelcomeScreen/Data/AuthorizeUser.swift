//
//  LoginRequest.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

import Foundation
import OAuth2
import Alamofire

final class AuthorizeUser {
    enum Error: Swift.Error {
        case loaderError
        case unknownUrl
        case loginNotFound
        case invalidResponse
    }
    
    let oauth2Model = Oauth2Model()
    
    func authenticate(completion: @escaping (Result<UserEntity, Swift.Error>) -> Void) {
        guard
            let base = URL(string: "https://api.github.com")
        else {
            completion(.failure(Error.unknownUrl))
            return
        }
        
        let url = base.appendingPathComponent("user")

        var req = oauth2Model.oauth2.request(forURL: url)
        req.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")

        let loader = OAuth2DataLoader(oauth2: oauth2Model.oauth2)
        loader.perform(request: req) { response in
            if response.error != nil {
                completion(.failure(Error.loaderError))
            }
            
            do {
                let userData = try response.responseJSON()
                guard
                    let userLogin = userData["login"] as? String
                else {
                    completion(.failure(Error.loginNotFound))
                    return
                }
                completion(.success(UserEntity(login: userLogin)))
            }
            catch {
                completion(.failure(Error.invalidResponse))
            }
        }
    }
}
