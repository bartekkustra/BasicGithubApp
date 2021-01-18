//
//  ListView.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

final class ListView: UIView, ListViewInterface {
    let searchBar = UISearchBar(frame: .zero)
    let contentStackView = UIStackView()
    let layoutButton = UIButton()
    let filterRepositoryButton = UIButton()
    let filterTeamButton = UIButton()
    let filterActivityButton = UIButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let activityIndicator = UIActivityIndicatorView()
}
