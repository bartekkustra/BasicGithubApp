//
//  TestDetailsViewModel.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class CustomDetailsViewModel: DetailsViewModel {
    enum Error: Swift.Error {
        case selfDeallocated
    }
    private let repositoryName: String
    private let endpoint: RepositoryDetailsProviding
    private let mapper: RepositoryDetailsMapping
    
    var title: String = "Details"
    var details: DetailsProtocol?
    
    init(
        repositoryName: String,
        endpoint: GetRepositoryDetailsEndpoint,
        mapper: RepositoryDetailsMapping
    ) {
        self.repositoryName = repositoryName
        self.endpoint = endpoint
        self.mapper = mapper
    }
    
    func update(completion: @escaping (Swift.Error?) -> Void) {
        endpoint.getDetails(repository: repositoryName) { [weak self] result in
            guard
                let strongSelf = self
            else {
                completion(Error.selfDeallocated)
                return
            }
            switch result {
            case let .success(details):
                let result = strongSelf.mapper.map(from: details)
                strongSelf.details = result
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }
}
