//
//  DetailsViewDependencyConfigurator.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class DetailsViewDependencyConfigurator {
    func configure(authModel: Oauth2Model?, repositoryName: String) -> UIViewController {
        let appearanceManager = DetailsViewAppearanceManager()
        let layoutManager = DetailsViewLayoutManager()
        let viewFactory = DetailsViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )
         
        let endpoint = GetRepositoryDetailsEndpoint(authModel: authModel)
        let mapper = RepositoryDetailsMapper()
        let viewModel = CustomDetailsViewModel(
            repositoryName: repositoryName,
            endpoint: endpoint,
            mapper: mapper
        )
        
        let viewController = DetailsViewController(
            viewFactory: viewFactory,
            viewModel: viewModel
        )
        
        return viewController
    }
}
