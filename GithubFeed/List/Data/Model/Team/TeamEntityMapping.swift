//
//  TeamEntityMapping.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

protocol TeamEntityMapping {
    func map(from entity: TeamEntity) -> ListItemProtocol
}
