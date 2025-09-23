//
//  AboutPresenter.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

final class AboutPresenter {
    weak var view: AboutViewInput?
    private let router: AboutRouterInput

    init(router: AboutRouterInput) { self.router = router }
}

extension AboutPresenter: AboutViewOutput {
    func viewDidLoad() {
        view?.render(text: "VIPER Counter\nVersion 1.0")
    }
}
