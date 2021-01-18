//
//  ListSectionProtocol.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

protocol ListSectionProtocol {
    var title: String { get }
    var type: SectionType { get }
    var items: [ListItemProtocol] { get }
    var isSelectable: Bool { get }
}
