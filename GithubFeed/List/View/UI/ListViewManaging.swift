//
//  ListViewManaging.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

protocol ListViewManaging {
    func showErrorState(on view: ListViewInterface)
    func hideErrorState(from view: ListViewInterface)
}
