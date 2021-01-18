//
//  ListDataSourceProtocol.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

protocol ListDataSourceProtocol {
    var sections: [ListSectionProtocol] { get set }
    var isListView: Bool { get set }
    
    func setup(collectionView: UICollectionView)
}
