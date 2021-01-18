//
//  StoredItemEntity.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

struct StoredItemEntity {
    let itemTitle: String
    let itemShortTitle: String
    let itemDescription: String
    
    init(
        itemTitle: String,
        itemShortTitle: String,
        itemDescription: String
    ) {
        self.itemTitle = itemTitle
        self.itemShortTitle = itemShortTitle
        self.itemDescription = itemDescription
    }
}
