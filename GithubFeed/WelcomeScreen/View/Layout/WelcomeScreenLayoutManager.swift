//
//  WelcomeScreenLayoutManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class WelcomeScreenLayoutManager {
    private func setupHierarchy(in view: WelcomeScreenInterface) {
        view.addSubview(view.image)
        view.addSubview(view.descriptionLabel)
        view.addSubview(view.loginButton)
        view.addSubview(view.activityIndicator)
    }
    
    private func setupConstraints(in view: WelcomeScreenInterface) {
        view.image.translatesAutoresizingMaskIntoConstraints = false
        view.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            view.image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.image.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            view.descriptionLabel.topAnchor.constraint(equalTo: view.image.bottomAnchor, constant: 30),
            view.descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            view.descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            view.loginButton.topAnchor.constraint(equalTo: view.descriptionLabel.bottomAnchor, constant: 40),
            view.loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            view.loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            view.loginButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            view.loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            view.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension WelcomeScreenLayoutManager: WelcomeScreenLayoutManaging {
    func layout(view: WelcomeScreenInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
