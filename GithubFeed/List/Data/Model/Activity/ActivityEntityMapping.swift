//
//  ActivityEntityMapping.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

protocol ActivityEntityMapping{
    func map(from entity: ActivityEntity) -> ListItemProtocol
}
