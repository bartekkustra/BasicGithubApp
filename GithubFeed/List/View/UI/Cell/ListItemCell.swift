//
//  ListItemCell.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

final class ListItemCell: UICollectionViewCell, ItemCellInterface {
    let title = UILabel()
    let image = UIImageView()
    let itemDescription = UILabel()
    
    private var titleLeadingConstraint: NSLayoutConstraint?
    private var imageTrailingConstraint: NSLayoutConstraint?
    private var titleBottomConstraint: NSLayoutConstraint?
    private var descriptionTopConstraint: NSLayoutConstraint?
    
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
            //TODO: check constraints
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            image.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.widthAnchor.constraint(lessThanOrEqualToConstant: 25),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            itemDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemDescription.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            itemDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        title.numberOfLines = 0
        itemDescription.numberOfLines = 0
        
        let titleLeadingConstraint = title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        self.titleLeadingConstraint = titleLeadingConstraint
        
        let imageTrailingConstraint = image.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -8)
        self.imageTrailingConstraint = imageTrailingConstraint
        
        let titleBottomConstraint = title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        titleBottomConstraint.priority = .defaultLow
        self.titleBottomConstraint = titleBottomConstraint
        
        let descriptionTopConstraint = itemDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10)
        self.descriptionTopConstraint = descriptionTopConstraint
        
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
        itemDescription.setContentHuggingPriority(.defaultLow, for: .vertical)
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
            titleBottomConstraint?.isActive = false
            descriptionTopConstraint?.isActive = true
        } else {
            itemDescription.text = nil
            itemDescription.isHidden = true
            titleBottomConstraint?.isActive = true
            descriptionTopConstraint?.isActive = false
        }
    }
}
