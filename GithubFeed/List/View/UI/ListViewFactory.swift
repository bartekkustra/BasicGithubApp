//
//  ListViewFactory.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class ListViewFactory {
    private let appearanceManager: ListAppearanceManaging
    private let layoutManager: ListLayoutManaging
    
    init(
        appearanceManager: ListAppearanceManaging,
        layoutManager: ListLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension ListViewFactory: ListViewProducing {
    func make() -> ListViewInterface {
        let view = ListView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)

        return view
    }
}
