//
//  RepositoryDetailsMapper.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 18/01/2021.
//

import Foundation

final class RepositoryDetailsMapper {}

extension RepositoryDetailsMapper: RepositoryDetailsMapping {
    func map(from entity: RepositoryDetailsEntity) -> DetailsProtocol {
        let dateFormatterToDate = DateFormatter()
        dateFormatterToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterToString = DateFormatter()
        dateFormatterToString.dateFormat = "yyyy-MM-dd"
        
        var formatedDate = "Error"
        if let date = dateFormatterToDate.date(from: entity.createdAt ?? "") {
             formatedDate = dateFormatterToString.string(from: date)
        }
        
        return DetailsModel(
            repoTitle: entity.name ?? "Error",
            owner: entity.owner?.login ?? "Error",
            description: entity.description ?? "",
            language: entity.language ?? "",
            watchersCount: entity.watchers ?? 0,
            createdAt: formatedDate
        )
    }
}
