//
//  ItemCellInterface.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

protocol ItemCellInterface: UICollectionViewCell {
    var title: UILabel { get }
    var itemDescription: UILabel { get }
    var image: UIImageView { get }
}
