//
//  GetTeamsUseCase.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class GetTeamsUseCase {
    enum Error: Swift.Error {
        case selfDeallocated
    }
    private let endpoint: TeamEndpoint
    private let mapper: TeamEntityMapping
    
    init(
        endpoint: TeamEndpoint,
        mapper: TeamEntityMapping
    ) {
        self.endpoint = endpoint
        self.mapper = mapper
    }
    
    func getTeams(completion: @escaping (Result<[ListItemProtocol], Swift.Error>) -> Void) {
        endpoint.getTeams { [weak self] result in
            guard
                let strongSelf = self
            else {
                completion(.failure(Error.selfDeallocated))
                return
            }
            switch result {
            case let .success(teamEntities):
                let items = teamEntities.map {
                    strongSelf.mapper.map(from: $0)
                }
                completion(.success(items))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
