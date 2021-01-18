//
//  GetRepositoryUseCase.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class GetRepositoryUseCase {
    enum Error: Swift.Error {
        case selfDeallocated
    }
    private let endpoint: GitRepoEndpoint
    private let mapper: RepositoryEntityMapping
    
    init(
        endpoint: GitRepoEndpoint,
        mapper: RepositoryEntityMapping
    ) {
        self.endpoint = endpoint
        self.mapper = mapper
    }
    
    func getRepository(for userName: String, completion: @escaping (Result<[ListItemProtocol], Swift.Error>) -> Void) {
        endpoint.getRepository(for: userName) { [weak self] result in
            guard
                let strongSelf = self
            else {
                completion(.failure(Error.selfDeallocated))
                return
            }
            switch result {
            case let .success(repoEntities):
                let items = repoEntities.map {
                    strongSelf.mapper.map(from: $0)
                }
                completion(.success(items))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
