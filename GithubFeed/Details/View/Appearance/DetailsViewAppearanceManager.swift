//
//  DetailsViewAppearanceManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class DetailsViewAppearanceManager {}

extension DetailsViewAppearanceManager: DetailsViewAppearanceManaging {
    func decorate(view: DetailsViewInterface) {
        view.backgroundColor = .navyBlue()
        
        view.titleLabel.textColor = .ashen()
        view.titleLabel.textAlignment = .center
        view.titleLabel.numberOfLines = 0
        view.titleLabel.font = .preferredFont(forTextStyle: .title1)
        
        view.ownerLabel.textColor = .peach()
        view.ownerLabel.textAlignment = .center
        view.ownerLabel.numberOfLines = 0
        view.ownerLabel.font = .preferredFont(forTextStyle: .title2)
        
        view.descriptionLabel.textColor = .ashen()
        view.descriptionLabel.textAlignment = .center
        view.descriptionLabel.numberOfLines = 0
        view.descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        view.language.textColor = .sun()
        view.language.numberOfLines = 0
        view.language.textAlignment = .center
        
        view.watchersCount.textColor = .ashen()
        view.watchersCount.numberOfLines = 0
        view.watchersCount.textAlignment = .center
        
        view.createdAt.textColor = .ashen()
        view.createdAt.numberOfLines = 0
        view.createdAt.textAlignment = .center
    }
}
