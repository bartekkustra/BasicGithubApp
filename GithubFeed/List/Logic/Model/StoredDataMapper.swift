//
//  StoredDataMapper.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

final class StoredDataMapper {
    private func getType(for section: String) -> SectionType {
        switch section {
        case "Repository":
            return .repository
        case "Team":
            return .team
        case "Activity":
            return .activity
        default:
            return.activity
        }
    }
}

extension StoredDataMapper: StoredDataMapping {
    //TODO: refactor
    func map(from entities: [StoredItemEntity]) -> [ListSectionProtocol] {
        var items: [ListItemProtocol] = []
        
        for item in entities {
            let newItem = ListItem(
                title: item.itemTitle,
                shortTitle: item.itemShortTitle,
                //TODO: fix description
                description: item.itemDescription,
                image: nil
            )
            items.append(newItem)
        }
        
        return [ListSection(
            title: "Cashed data",
            type: .repository,
            items: items,
            isSelectable: false
        )]
    }
}
