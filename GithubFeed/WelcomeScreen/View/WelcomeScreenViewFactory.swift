//
//  WelcomeScreenViewFactory.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class WelcomeScreenViewFactory {
    private let appearanceManager: WelcomeScreenAppearanceManaging
    private let layoutManager: WelcomeScreenLayoutManaging
    
    init(
        appearanceManager: WelcomeScreenAppearanceManaging,
        layoutManager: WelcomeScreenLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension WelcomeScreenViewFactory: WelcomeScreenViewProducing {
    func make() -> WelcomeScreenInterface {
        let view = WelcomeScreenView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)
        
        return view
    }
}
