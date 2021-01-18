//
//  RepositoryDetailsMapping.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

protocol RepositoryDetailsMapping {
    func map(from entity: RepositoryDetailsEntity) -> DetailsProtocol
}
