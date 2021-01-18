//
//  TeamEntityMapper.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class TeamEntityMapper {}

extension TeamEntityMapper: TeamEntityMapping {
    func map(from entity: TeamEntity) -> ListItemProtocol {
        let name = entity.name ?? ""
        let description = entity.organizaionName ?? ""
        
        return ListItem(
            title: name,
            description: description,
            image: nil
        )
    }
}
