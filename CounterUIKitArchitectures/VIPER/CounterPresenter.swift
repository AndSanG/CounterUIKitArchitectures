//
//  CounterPresenter.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation

final class CounterPresenter {
    weak var view: CounterViewInput?
    private let interactor: CounterInteractorInput
    private let router: CounterRouterInput

    init(interactor: CounterInteractorInput, router: CounterRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    private func format(count: Int) {
        let text = "Count VIPER: \(count)"
        view?.render(countText: text, isResetEnabled: count > 0)
    }
}

extension CounterPresenter: CounterViewOutput {
    func viewDidLoad() {
        interactor.loadInitial()
    }

    func didTapIncrement() {
        interactor.increment()
    }

    func didTapReset() {
        interactor.reset()
    }
    
    func didTapAbout() {
        router.showAbout()
    }
}

extension CounterPresenter: CounterInteractorOutput {
    func didLoadCurrentCount(_ count: Int) {
        format(count: count)
    }

    func didUpdateCount(_ count: Int) {
        format(count: count)
    }
}
