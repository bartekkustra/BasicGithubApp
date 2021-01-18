//
//  DetailsViewFactory.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

final class DetailsViewFactory {
    private let appearanceManager: DetailsViewAppearanceManaging
    private let layoutManager: DetailsViewLayoutManaging
    
    init(
        appearanceManager: DetailsViewAppearanceManaging,
        layoutManager: DetailsViewLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension DetailsViewFactory: DetailsViewProducing {
    func make() -> DetailsViewInterface {
        let view = DetailsView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)

        return view
    }
}
