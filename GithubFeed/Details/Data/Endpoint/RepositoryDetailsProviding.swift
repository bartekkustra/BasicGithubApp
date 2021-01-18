//
//  RepositoryDetailsProviding.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

protocol RepositoryDetailsProviding {
    func getDetails(
            repository: String,
            completion: @escaping (Result<RepositoryDetailsEntity, Swift.Error>
        ) -> Void)
}
