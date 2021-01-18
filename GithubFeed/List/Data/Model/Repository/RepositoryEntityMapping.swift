//
//  RepositoryEntityMapping.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

protocol RepositoryEntityMapping {
    func map(from entity: GitRepoEntity) -> ListItemProtocol
}
