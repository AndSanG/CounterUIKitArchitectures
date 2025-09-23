//
//  AboutRouter.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation
import UIKit

final class AboutRouter: AboutRouterInput {
    weak var viewController: UIViewController?
}

enum AboutModule {
    static func build() -> UIViewController {
        let view = AboutViewController()
        let router = AboutRouter()
        let presenter = AboutPresenter(router: router)

        view.output = presenter
        presenter.view = view
        router.viewController = view
        return view
    }
}
