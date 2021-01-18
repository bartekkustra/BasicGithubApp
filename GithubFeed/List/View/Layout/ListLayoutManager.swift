//
//  ListLayoutManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class ListLayoutManager {
    private let layout: UICollectionViewFlowLayout
    
    init(layout: UICollectionViewFlowLayout) {
        self.layout = layout
    }
    
    private func setupHierarchy(in view: ListViewInterface) {
        view.addSubview(view.searchBar)
        
        view.addSubview(view.contentStackView)
        view.contentStackView.addArrangedSubview(view.filterRepositoryButton)
        view.contentStackView.addArrangedSubview(view.filterTeamButton)
        view.contentStackView.addArrangedSubview(view.filterActivityButton)
        view.contentStackView.addArrangedSubview(view.layoutButton)

        view.addSubview(view.collectionView)
        view.addSubview(view.activityIndicator)
    }
    
    private func setupConstraints(in view: ListViewInterface) {
        view.searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.filterRepositoryButton.translatesAutoresizingMaskIntoConstraints = false
        view.filterTeamButton.translatesAutoresizingMaskIntoConstraints = false
        view.filterActivityButton.translatesAutoresizingMaskIntoConstraints = false
        view.layoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            view.searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            view.contentStackView.topAnchor.constraint(equalTo: view.searchBar.bottomAnchor, constant: 10),
            view.contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            view.filterTeamButton.widthAnchor.constraint(equalTo: view.filterRepositoryButton.widthAnchor),
            view.filterActivityButton.widthAnchor.constraint(equalTo: view.filterTeamButton.widthAnchor),
            view.layoutButton.widthAnchor.constraint(equalTo: view.filterActivityButton.widthAnchor),
            
            view.collectionView.topAnchor.constraint(equalTo: view.contentStackView.bottomAnchor, constant: 10),
            view.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            view.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.contentStackView.axis = .horizontal
        view.contentStackView.spacing = 10
    }
}

extension ListLayoutManager: ListLayoutManaging {
    func layout(view: ListViewInterface) {
        view.collectionView.collectionViewLayout = layout
        
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
