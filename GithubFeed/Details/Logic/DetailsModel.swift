//
//  DetailsModel.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

struct DetailsModel: DetailsProtocol {
    var repoTitle: String
    var owner: String
    var description: String
    var language: String
    var watchersCount: Int
    var createdAt: String
    
    init(
        repoTitle: String,
        owner: String,
        description: String,
        language: String,
        watchersCount: Int,
        createdAt: String
    ) {
        self.repoTitle = repoTitle
        self.owner = owner
        self.description = description
        self.language = language
        self.watchersCount = watchersCount
        self.createdAt = createdAt
    }
}
