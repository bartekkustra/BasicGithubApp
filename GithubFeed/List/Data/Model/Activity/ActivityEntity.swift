//
//  ActivityEntity.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

struct ActivityEntity: Codable {
    let type: String?
    let actor: ActorEntity?
    let repo: RepoEntity?
    let payload: PayloadEntity?
}

struct ActorEntity: Codable {
    let displayLogin: String?
    let avatarUrl: String?
}

struct RepoEntity: Codable {
    let name: String?
}

struct PayloadEntity: Codable {
    let description: String?
}
