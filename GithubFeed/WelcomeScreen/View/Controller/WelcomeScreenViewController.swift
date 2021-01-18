//
//  WelcomeScreenViewController.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 13/01/2021.
//

import UIKit

final class WelcomeScreenViewController: UIViewController {
    private let viewFactory: WelcomeScreenViewFactory
    private let authenticateUser: AuthorizeUser
    private let router: Router
    
    private lazy var welcomeScreenView = viewFactory.make()
    
    init(
        viewFactory: WelcomeScreenViewFactory,
        loginRequest: AuthorizeUser,
        router: Router
    ) {
        self.viewFactory = viewFactory
        self.authenticateUser = loginRequest
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = welcomeScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .lighterBlue()
        
        welcomeScreenView.image.image = UIImage(named: "logo")
        welcomeScreenView.descriptionLabel.text = "Welcome to my basic Github feed app!"
        welcomeScreenView.loginButton.setTitle("Sign in via Github!", for: .normal)
        
        welcomeScreenView.loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func login(_ sender: UIControl) {
        welcomeScreenView.activityIndicator.startAnimating()
        authenticateUser.authenticate { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(user):
                    self?.welcomeScreenView.activityIndicator.stopAnimating()
                    let viewController = ListDependencyConfigurator().configure(
                        userModel: user,
                        authModel: self?.authenticateUser.oauth2Model
                    )
                    self?.router.route(to: viewController)
                case let .failure(error):
                    self?.welcomeScreenView.activityIndicator.stopAnimating()
                    fatalError("Error occured: \(error)")
                    //TODO: HandleError
                }
            }
        }
    }
}
