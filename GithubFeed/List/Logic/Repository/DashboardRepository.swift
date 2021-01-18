//
//  DashboardRepository.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

import UIKit

final class DashboardRepository {
    enum Error: Swift.Error {
        case selfDeallocated
    }
    
    //TODO: add useCase protocol
    private let teamUseCase: GetTeamsUseCase
    private let activityUseCase: GetActivityUseCase
    private let repoUseCase: GetRepositoryUseCase
    
    init(
        teamUseCase: GetTeamsUseCase,
        activityUseCase: GetActivityUseCase,
        repoUseCase: GetRepositoryUseCase
    ) {
        self.teamUseCase = teamUseCase
        self.activityUseCase = activityUseCase
        self.repoUseCase = repoUseCase
    }
}

extension DashboardRepository: DashboardProducing {
    func loadDashboard(for user: String, completion: @escaping (Result<[ListSectionProtocol], Swift.Error>) -> Void) {
        let group = DispatchGroup()
        var loadingError: Swift.Error?
        
        var listSections: [ListSectionProtocol] = []
        
        var repositorySection: ListSectionProtocol?
        var teamSection: ListSectionProtocol?
        var activitySection: ListSectionProtocol?
        
        group.enter()
        repoUseCase.getRepository(for: user) { result in
            switch result {
            case let .success(repositories):
                let section = ListSection(
                    title: "Repository",
                    type: .repository,
                    items: repositories,
                    isSelectable: true
                )
                repositorySection = section
            case let .failure(error):
                loadingError = error
            }
            group.leave()
        }
        
        group.enter()
        teamUseCase.getTeams { result in
            switch result {
            case let .success(teams):
                let section = ListSection(
                    title: "Teams",
                    type: .team,
                    items: teams
                )
                teamSection = section
            case let .failure(error):
                loadingError = error
            }
            group.leave()
        }
        
        group.enter()
        activityUseCase.getActivity(for: user) { result in
            switch result {
            case let .success(activity):
                let section = ListSection(
                    title: "Activity",
                    type: .activity,
                    items: activity
                )
                activitySection = section
            case let .failure(error):
                loadingError = error
            }
            group.leave()
        }
        
        DispatchQueue.global().async {
            group.wait()
            if let error = loadingError {
                completion(.failure(error))
                return
            }
            
            if let section = repositorySection {
                listSections.append(section)
            }
            if let section = teamSection {
                listSections.append(section)
            }
            if let section = activitySection {
                listSections.append(section)
            }
            completion(.success(listSections))
        }
    }
}
