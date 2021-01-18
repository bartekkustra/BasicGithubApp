//
//  RepositoryDetailsEntity.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

struct RepositoryDetailsEntity: Codable {
    let name: String?
    let owner: Owner?
    let description: String?
    let createdAt: String?
    let watchers: Int?
    let language: String?
}

struct Owner: Codable {
    let login: String?
}
