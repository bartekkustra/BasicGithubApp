//
//  DetailsProtocol.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

protocol DetailsProtocol {
    var repoTitle: String { get }
    var owner: String { get }
    var description: String { get }
    var language: String { get }
    var watchersCount: Int { get }
    var createdAt: String { get }
}
