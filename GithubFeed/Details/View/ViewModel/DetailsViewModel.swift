//
//  DetailsViewModel.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

protocol DetailsViewModel {
    var title: String { get }
    var details: DetailsProtocol? { get }
    
    func update(completion: @escaping (Error?) -> Void)
}
