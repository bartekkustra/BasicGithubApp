//
//  ListItemCellAppearanceManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

final class ListItemCellAppearanceManager {}

extension ListItemCellAppearanceManager: ListItemCellAppearanceManaging {
    func decorate(cell: ItemCellInterface, style: ItemCellStyle) {
        cell.layer.cornerRadius = 4.0
        cell.clipsToBounds = true
        cell.backgroundColor = .lighterBlue()
        cell.itemDescription.textColor = .ashen()
        
        switch style {
        case .custom:
            cell.title.textColor = .peach()
        case .list:
            cell.title.textColor = .sun()
        }
    }
}
