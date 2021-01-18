//
//  ListDependencyConfigurator.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class ListDependencyConfigurator {
    func configure(userModel: UserEntity, authModel: Oauth2Model?) -> UIViewController {
        let appearanceManager = ListAppearanceManager()
        let collectionViewLayout = UICollectionViewFlowLayout()
        let layoutManager = ListLayoutManager(layout: collectionViewLayout)
        let viewFactory = ListViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )

        let teamsEndpoint = TeamEndpoint(authModel: authModel)
        let teamsMapper = TeamEntityMapper()
        let teamUseCase = GetTeamsUseCase(
            endpoint: teamsEndpoint,
            mapper: teamsMapper
        )
        
        let activityEndpoint = ActivityEndpoint(authModel: authModel)
        let activityMapper = ActivityEntityMapper()
        let activityUseCase = GetActivityUseCase(
            endpoint: activityEndpoint,
            mapper: activityMapper
        )
        
        let repositoryEndpoint = GitRepoEndpoint(authModel: authModel)
        let repositoryMapper = RepositoryEntityMapper()
        let repoUseCase = GetRepositoryUseCase(
            endpoint: repositoryEndpoint,
            mapper: repositoryMapper
        )
        
        let dashboardRepository = DashboardRepository(
            teamUseCase: teamUseCase,
            activityUseCase: activityUseCase,
            repoUseCase: repoUseCase
        )
         
        let storedDataMapper = StoredDataMapper()
        let viewModel = ListCustomViewModel(
            userModel: userModel,
            repository: dashboardRepository,
            storedDataMapper: storedDataMapper
        )
        
        let cellAppearanceManager = ListItemCellAppearanceManager()
        let headerLayoutManager = ListSectionHeaderAppearanceManager()
        let dataSource = ListDataSource(
            cellAppearanceManager: cellAppearanceManager,
            headerLayoutManager: headerLayoutManager
        )
        
        let router = Router()
        
        let viewController = ListViewController(
            viewFactory: viewFactory,
            viewModel: viewModel,
            dataSource: dataSource,
            layout: collectionViewLayout,
            router: router,
            authModel: authModel
        )
        router.parent = viewController
        
        return viewController
    }
}
