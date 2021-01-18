//
//  GitRepoProviding.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

protocol GitRepoProviding {
    func getRepository(for user: String, completion: @escaping (Result<[GitRepoEntity], Swift.Error>) -> Void)
}
