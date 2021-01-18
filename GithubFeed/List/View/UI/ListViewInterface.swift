//
//  ListInterface.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

protocol ListViewInterface: UIView {
    var searchBar: UISearchBar { get }
    var contentStackView: UIStackView { get }
    var filterRepositoryButton: UIButton { get }
    var filterTeamButton: UIButton { get }
    var filterActivityButton: UIButton { get }
    var layoutButton: UIButton { get }
    var collectionView: UICollectionView { get }
    var activityIndicator: UIActivityIndicatorView { get }
}
