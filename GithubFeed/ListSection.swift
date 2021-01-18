//
//  ListSection.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

struct ListSection: ListSectionProtocol {
    let title: String
    let type: SectionType
    let items: [ListItemProtocol]
    let isSelectable: Bool
    
    init(
        title: String,
        type: SectionType,
        items: [ListItemProtocol],
        isSelectable: Bool = false
    ) {
        self.title = title
        self.type = type
        self.items = items
        self.isSelectable = isSelectable
    }
}
