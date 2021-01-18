//
//  Router.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 15/01/2021.
//

import UIKit

final class Router {
    var parent: UIViewController?
    
    func route(to controller: UIViewController) {
        guard
            let parent = parent
        else {
            return
        }
        
        parent.navigationController?.pushViewController(controller, animated: true)
    }
}
