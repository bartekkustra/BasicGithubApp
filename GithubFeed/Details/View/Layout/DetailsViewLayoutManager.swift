//
//  DetailsViewLayoutManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class DetailsViewLayoutManager {
    private func setupHierarchy(in view: DetailsViewInterface) {
        view.addSubview(view.titleLabel)
        view.addSubview(view.ownerLabel)
        
        view.addSubview(view.contentStackView)
        view.contentStackView.addArrangedSubview(view.language)
        view.contentStackView.addArrangedSubview(view.watchersCount)
        view.contentStackView.addArrangedSubview(view.createdAt)
        
        view.addSubview(view.descriptionLabel)
        view.addSubview(view.activityIndicator)
    }
    
    private func setupConstraints(in view: DetailsViewInterface) {
        view.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.language.translatesAutoresizingMaskIntoConstraints = false
        view.watchersCount.translatesAutoresizingMaskIntoConstraints = false
        view.createdAt.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            view.titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            view.ownerLabel.topAnchor.constraint(equalTo: view.titleLabel.bottomAnchor, constant: 20),
            view.ownerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.ownerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            view.contentStackView.topAnchor.constraint(equalTo: view.ownerLabel.bottomAnchor, constant: 40),
            view.contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            view.descriptionLabel.topAnchor.constraint(equalTo: view.contentStackView.bottomAnchor, constant: 10),
            view.descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view.descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            view.descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            view.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.contentStackView.axis = .horizontal
        view.contentStackView.spacing = 5
        
        view.titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.ownerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}

extension DetailsViewLayoutManager: DetailsViewLayoutManaging {
    func layout(view: DetailsViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
