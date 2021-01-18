//
//  DashboardProducing.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//


protocol DashboardProducing {
    func loadDashboard(for user: String, completion: @escaping (Result<[ListSectionProtocol], Swift.Error>) -> Void)
}
