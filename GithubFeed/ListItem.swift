//
//  ListItem.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

struct ListItem: ListItemProtocol {
    let title: String
    let shortTitle: String?
    let description: String?
    let image: String?
    
    init(
        title: String,
        shortTitle: String? = nil,
        description: String? = nil,
        image: String? = nil
    ) {
        self.title = title
        self.shortTitle = shortTitle
        self.description = description
        self.image = image
    }
}
