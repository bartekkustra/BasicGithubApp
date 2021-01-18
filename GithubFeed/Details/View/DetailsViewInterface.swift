//
//  DetailsViewInterface.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

protocol DetailsViewInterface: UIView {
    var titleLabel: UILabel { get }
    var ownerLabel: UILabel { get }
    var descriptionLabel: UILabel { get }
    var contentStackView: UIStackView { get }
    var language: UILabel { get }
    var watchersCount: UILabel { get }
    var createdAt: UILabel { get }
    var activityIndicator: UIActivityIndicatorView { get }
}
