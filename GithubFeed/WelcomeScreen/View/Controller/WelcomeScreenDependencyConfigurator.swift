//
//  WelcomeScreenDependencyConfigurator.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class WelcomeScreenDependencyConfigurator {
    private let authorizeUser: AuthorizeUser
    
    init(authorizeUser: AuthorizeUser) {
        self.authorizeUser = authorizeUser
    }
    
    func configure() -> UIViewController {
        let appearanceManager = WelcomeScreenAppearanceManager()
        let layoutManager = WelcomeScreenLayoutManager()
        let viewFactory = WelcomeScreenViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )
        
        let router = Router()
        
        let viewController = WelcomeScreenViewController(
            viewFactory: viewFactory,
            loginRequest: authorizeUser,
            router: router
        )
        router.parent = viewController
        
        return viewController
    }
}
