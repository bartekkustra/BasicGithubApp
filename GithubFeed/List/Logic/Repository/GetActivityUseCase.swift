//
//  GetActivityUseCase.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class GetActivityUseCase {
    enum Error: Swift.Error {
        case selfDeallocated
    }
    private let endpoint: ActivityEndpoint
    private let mapper: ActivityEntityMapping
    
    init(
        endpoint: ActivityEndpoint,
        mapper: ActivityEntityMapping
    ) {
        self.endpoint = endpoint
        self.mapper = mapper
    }
    
    func getActivity(for userName: String, completion: @escaping (Result<[ListItemProtocol], Swift.Error>) -> Void) {
        endpoint.getActivity(for: userName) { [weak self] result in
            guard
                let strongSelf = self
            else {
                completion(.failure(Error.selfDeallocated))
                return
            }
            switch result {
            case let .success(activityEntities):
                let items = activityEntities.map {
                    strongSelf.mapper.map(from: $0)
                }
                completion(.success(items))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
