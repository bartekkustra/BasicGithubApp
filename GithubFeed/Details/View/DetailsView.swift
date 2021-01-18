//
//  DetailsView.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class DetailsView: UIView, DetailsViewInterface {
    let titleLabel = UILabel()
    let ownerLabel = UILabel()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    let language = UILabel()
    let watchersCount = UILabel()
    let createdAt = UILabel()
    let activityIndicator = UIActivityIndicatorView()
}
