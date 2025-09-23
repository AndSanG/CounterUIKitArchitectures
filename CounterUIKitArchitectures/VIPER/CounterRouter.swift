//
//  CounterRouter.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import UIKit

final class CounterRouter: CounterRouterInput {
    weak var viewController: UIViewController?
    
    func showAbout() {
        let aboutVC = AboutModule.build()             
        if let nav = viewController?.navigationController {
            nav.pushViewController(aboutVC, animated: true)
        } else {
            viewController?.present(UINavigationController(rootViewController: aboutVC), animated: true)
        }
    }
}

// Module builder
enum CounterModule {
    static func build() -> UIViewController {
        let view = CounterViewController()
        let interactor = CounterInteractor(initialCount: 5)
        let router = CounterRouter()
        let presenter = CounterPresenter(interactor: interactor, router: router)
        
        // Wire dependencies
        view.output = presenter
        presenter.view = view
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
