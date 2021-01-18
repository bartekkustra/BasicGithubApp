//
//  ListAppearanceManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class ListAppearanceManager {}

extension ListAppearanceManager: ListAppearanceManaging {
    func decorate(view: ListViewInterface) {
        view.backgroundColor = .navyBlue()
        view.collectionView.backgroundColor = .clear
        
        view.searchBar.layer.cornerRadius = 4.0
        view.searchBar.tintColor = .peach()
        view.searchBar.barTintColor = .navyBlue()
        view.searchBar.searchTextField.textColor = .ashen()
        
        view.filterRepositoryButton.layer.cornerRadius = 4.0
        view.filterTeamButton.layer.cornerRadius = 4.0
        view.filterActivityButton.layer.cornerRadius = 4.0
        
        view.layoutButton.layer.cornerRadius = 4.0
        view.layoutButton.layer.borderWidth = 1
        view.layoutButton.layer.borderColor = UIColor.ashen().cgColor
    }
}
