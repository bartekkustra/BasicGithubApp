//
//  ActivityProviding.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

protocol ActivityProviding {
    func getActivity(for userName: String, completion: @escaping (Result<[ActivityEntity], Swift.Error>) -> Void)
}
