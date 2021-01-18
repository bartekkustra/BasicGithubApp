//
//  StoredDataMapping.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

protocol StoredDataMapping {
    func map(from entities: [StoredItemEntity]) -> [ListSectionProtocol]
}
