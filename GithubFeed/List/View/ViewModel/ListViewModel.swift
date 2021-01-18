//
//  MenuViewModel.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

protocol ListViewModel {
    var title: String { get }
    var sections: [ListSectionProtocol] { get }
    var filters: [SectionType] { get }
    
    func update(completion: @escaping (_ error: Error?) -> Void)
    func apply() -> [ListSectionProtocol]
    func remove(currentFilters: SectionType)
    func add(currentFilters: SectionType)
    func updateForOffline(storedData: [StoredItemEntity])
}
