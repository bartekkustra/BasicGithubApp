//
//  WelcomeScreenInterface.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

protocol WelcomeScreenInterface: UIView {
    var image: UIImageView { get }
    var descriptionLabel: UILabel { get }
    var loginButton: UIButton { get }
    var activityIndicator: UIActivityIndicatorView { get }
}
