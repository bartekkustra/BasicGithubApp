//
//  ListDataSource.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

final class ListDataSource: NSObject {
    private let customCellReusableIdentifier = "DataSourceItemCustomCell"
    private let listCellReusableIdentifier = "DataSourceItemListCell"
    private let headerReusableIdentifier = "DataSourceHeader"
    private let cellAppearanceManager: ListItemCellAppearanceManaging
    private let headerLayoutManager: ListSectionHeaderAppearanceManaging
    
    var sections: [ListSectionProtocol] = []
    var isListView: Bool = true
    
    init(
        cellAppearanceManager: ListItemCellAppearanceManaging,
        headerLayoutManager: ListSectionHeaderAppearanceManaging
    ) {
        self.cellAppearanceManager = cellAppearanceManager
        self.headerLayoutManager = headerLayoutManager
        
        super.init()
    }
}

extension ListDataSource: ListDataSourceProtocol {
    func setup(collectionView: UICollectionView) {
        collectionView.register(
            ListSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerReusableIdentifier
        )
        
        collectionView.register(
            ListItemCell.self,
            forCellWithReuseIdentifier: listCellReusableIdentifier
        )
        
        collectionView.register(
            CustomItemCell.self,
            forCellWithReuseIdentifier: customCellReusableIdentifier
        )
    }
}

extension ListDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellReusableIdentifier, for: indexPath)
            if let cell = cell as? ListItemCell {
                let section = sections[indexPath.section]
                let item = section.items[indexPath.item]
                cell.setup(with: item)
                cellAppearanceManager.decorate(cell: cell, style: .list)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellReusableIdentifier, for: indexPath)
            if let cell = cell as? CustomItemCell {
                let section = sections[indexPath.section]
                let item = section.items[indexPath.item]
                cell.setup(with: item)
                cellAppearanceManager.decorate(cell: cell, style: .custom)
            }
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerReusableIdentifier,
            for: indexPath
        )

        if let view = view as? ListSectionHeaderView {
            let section = sections[indexPath.section]
            view.setup(with: section)
            headerLayoutManager.decorate(view: view)
        }
        return view
    }
}

