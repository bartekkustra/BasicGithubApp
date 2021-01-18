//
//  ListItemProtocol.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

protocol ListItemProtocol {
    var title: String { get }
    var shortTitle: String? { get }
    var description: String? { get }
    var image: String? { get }
}
