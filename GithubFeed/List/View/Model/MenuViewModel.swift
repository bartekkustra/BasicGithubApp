//
//  MenuViewModel.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

protocol ListViewModel {
    var title: String { get }
    var sections: [ListSectionsProtocol] { get }
    
    func update(completion: @escaping (_ error: Error?) -> Void)
}
