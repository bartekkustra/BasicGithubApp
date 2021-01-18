//
//  DetailsViewController.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 16/01/2021.
//

import UIKit

final class DetailsViewController: UIViewController {
    private let viewFactory: DetailsViewFactory
    private let viewModel: DetailsViewModel

    private lazy var detailsView = viewFactory.make()
    
    init(
        viewFactory: DetailsViewFactory,
        viewModel: DetailsViewModel
    ) {
        self.viewFactory = viewFactory
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewModel()
    }
    
    private func updateViewModel() {
        detailsView.activityIndicator.startAnimating()
        viewModel.update() { [weak self] error in
            DispatchQueue.main.async {
                self?.detailsView.activityIndicator.stopAnimating()
                if let error = error {
                    self?.handleError(error)
                    return
                }
                self?.viewModelDidUpdate()
            }
        }
    }
    
    private func handleError(_ error: Error) {
        //TODO: Add error handler
        navigationItem.title = "Error occured"
    }
    
    private func viewModelDidUpdate() {
        navigationItem.title = viewModel.title
        
        detailsView.titleLabel.text = viewModel.details?.repoTitle
        detailsView.ownerLabel.text = "Owner: \(viewModel.details?.owner ?? "Unknown")"
        detailsView.descriptionLabel.text = viewModel.details?.description

        //TODO: Add additional labels in stackView for Created, Language, Watchers
        detailsView.createdAt.text = "Created: \n\(viewModel.details?.createdAt ?? "Error")"
        detailsView.language.text = "Language: \n\(viewModel.details?.language ?? "Error")"
        detailsView.watchersCount.text = "Watchers: \n\(String(viewModel.details?.watchersCount ?? 0))"
    }
}
