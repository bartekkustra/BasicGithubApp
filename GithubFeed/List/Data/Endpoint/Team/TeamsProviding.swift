//
//  TeamsProviding.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

protocol TeamsProviding {
    func getTeams(completion: @escaping (Result<[TeamEntity], Swift.Error>) -> Void)
}
