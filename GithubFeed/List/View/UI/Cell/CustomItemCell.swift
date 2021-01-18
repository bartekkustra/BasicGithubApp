//
//  CustomItemCell.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class CustomItemCell: UICollectionViewCell, ItemCellInterface {
    let title = UILabel()
    let image = UIImageView()
    let itemDescription = UILabel()
    
    private var titleLeadingConstraint: NSLayoutConstraint?
    private var imageTrailingConstraint: NSLayoutConstraint?
    private var descriptionBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    private func setupHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(image)
        contentView.addSubview(itemDescription)
    }
    
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        itemDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //TODO: Check constraints
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            
            image.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.widthAnchor.constraint(lessThanOrEqualToConstant: 25),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            itemDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemDescription.trailingAnchor.constraint(equalTo: title.trailingAnchor),
        ])
        
        title.numberOfLines = 0
        itemDescription.numberOfLines = 0
        
        let titleLeadingConstraint = title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        self.titleLeadingConstraint = titleLeadingConstraint
        
        let imageTrailingConstraint = image.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -8)
        self.imageTrailingConstraint = imageTrailingConstraint
        
        let descriptionBottomConstraint = itemDescription.bottomAnchor.constraint(lessThanOrEqualTo: title.topAnchor, constant: -10)
        self.descriptionBottomConstraint = descriptionBottomConstraint
    }
    
    func setup(with model: ListItemProtocol) {
        title.text = model.title
        
        if
            let imageName = model.image,
            let imageUrl = URL(string: imageName)
        {
            image.load(url: imageUrl)
            image.isHidden = false
            titleLeadingConstraint?.isActive = false
            imageTrailingConstraint?.isActive = true
        } else {
            image.image = nil
            image.isHidden = true
            titleLeadingConstraint?.isActive = true
            imageTrailingConstraint?.isActive = false
        }
        
        if let descriptionText = model.description {
            itemDescription.text = descriptionText
            itemDescription.isHidden = false
            descriptionBottomConstraint?.isActive = true
        } else {
            itemDescription.text = nil
            itemDescription.isHidden = true
            descriptionBottomConstraint?.isActive = false
        }
    }
}
