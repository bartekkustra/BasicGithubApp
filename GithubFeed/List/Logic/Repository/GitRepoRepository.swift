//
//  GitRepoRepository.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class GetRepositoryUseCase {
    enum Error: Swift.Error {
        case test
    }
    private let endpoint: GitRepoEndpoint
    //mapper?
    
    init(endpoint: GitRepoEndpoint) {
        self.endpoint = endpoint
    }
    
    func getRepository(completion: @escaping (Result<[GitRepoEntity], Swift.Error>) -> Void) {
        //TODO
        endpoint.getRepository { [weak self] result in
            
            completion(.failure(Error.test))
        }
    }
}
