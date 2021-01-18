//
//  RepositoryEntityMapper.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

final class RepositoryEntityMapper {}

extension RepositoryEntityMapper: RepositoryEntityMapping {
    func map(from entity: GitRepoEntity) -> ListItemProtocol {
        let name = entity.fullName ?? ""
        let shortTitle = entity.name ?? ""
        let description = entity.description ?? ""
        
        return ListItem(
            title: name,
            shortTitle: shortTitle,
            description: description,
            image: nil
        )
    }
}
