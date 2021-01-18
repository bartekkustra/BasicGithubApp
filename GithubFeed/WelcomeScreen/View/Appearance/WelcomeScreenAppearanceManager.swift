//
//  WelcomeScreenAppearanceManager.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class WelcomeScreenAppearanceManager {}

extension WelcomeScreenAppearanceManager: WelcomeScreenAppearanceManaging {
    func decorate(view: WelcomeScreenInterface) {
        view.backgroundColor = .navyBlue()
        
        view.image.contentMode = .scaleAspectFit
        
        view.descriptionLabel.textColor = .ashen()
        view.descriptionLabel.textAlignment = .center
        view.descriptionLabel.numberOfLines = 0
        view.descriptionLabel.font = .preferredFont(forTextStyle: .headline)
        
        view.loginButton.backgroundColor = .lighterBlue()
        view.loginButton.layer.borderWidth = 1
        view.loginButton.layer.borderColor = UIColor.peach().cgColor
        view.loginButton.layer.cornerRadius = 4
    }
}
