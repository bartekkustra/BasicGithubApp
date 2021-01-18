//
//  ListSectionHeaderAppearanceManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

final class ListSectionHeaderAppearanceManager {}

extension ListSectionHeaderAppearanceManager: ListSectionHeaderAppearanceManaging {
    func decorate(view: ListSectionHeaderViewInterface) {
        view.backgroundColor = .ashen()
        view.titleLabel.font = .preferredFont(forTextStyle: .headline)
        view.layer.cornerRadius = 4.0
    }
}
