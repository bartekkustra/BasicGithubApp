//
//  ActivityEntityMapper.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class ActivityEntityMapper {}

extension ActivityEntityMapper: ActivityEntityMapping {
    func map(from entity: ActivityEntity) -> ListItemProtocol {
        let name = entity.repo?.name ?? ""
        let type = entity.type ?? ""
        let user = entity.actor?.displayLogin ?? ""
        let description = entity.payload?.description ?? ""
        let image = entity.actor?.avatarUrl ?? ""
        
        let actionDescription = "\(user) (\(type)) \(description)"
        
        return ListItem(
            title: name,
            description: actionDescription,
            image: image
        )
    }
}
