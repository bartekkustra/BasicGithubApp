//
//  TestViewModel.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import Foundation
import UIKit

final class ListCustomViewModel: ListViewModel {
    enum Error: Swift.Error {
        case selfDeallocated
    }
    
    private let userModel: UserEntity
    private let repository: DashboardProducing
    private let storedDataMapper: StoredDataMapping
    
    var title = ""
    var sections: [ListSectionProtocol] = []
    var filters: [SectionType] = []
    
    init(
        userModel: UserEntity,
        repository: DashboardProducing,
        storedDataMapper: StoredDataMapping
    ) {
        self.userModel = userModel
        self.repository = repository
        self.storedDataMapper = storedDataMapper
        
        title = "Hello \(userModel.login)!"
    }
    
    func apply() -> [ListSectionProtocol] {
        if filters.isEmpty {
            return sections
        } else {
            let filteredSections = sections.filter {
                filters.contains($0.type)
            }
            return filteredSections
        }
    }
    
    func remove(currentFilters: SectionType) {
        filters = filters.filter {
            $0 != currentFilters
        }
    }

    func add(currentFilters: SectionType) {
        filters.append(currentFilters)
    }

    func update(completion: @escaping (Swift.Error?) -> Void) {
        repository.loadDashboard(for: userModel.login) { [weak self] result in
            guard
                let strongSelf = self
            else {
                completion(Error.selfDeallocated)
                return
            }
            switch result {
            case let .success(sections):
                strongSelf.sections = sections
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }
    
    func updateForOffline(storedData: [StoredItemEntity]) {
        sections = storedDataMapper.map(from: storedData)
    }
}
