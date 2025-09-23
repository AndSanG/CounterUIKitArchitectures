//
//  CounterContracts.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation
import UIKit

// VIEW talks to PRESENTER
protocol CounterViewOutput: AnyObject {
    func viewDidLoad()
    func didTapIncrement()
    func didTapReset()
    func didTapAbout() 
}

// PRESENTER talks to VIEW
protocol CounterViewInput: AnyObject {
    func render(countText: String, isResetEnabled: Bool)
}

// PRESENTER talks to INTERACTOR
protocol CounterInteractorInput: AnyObject {
    func loadInitial()
    func increment()
    func reset()
}

// INTERACTOR talks back to PRESENTER
protocol CounterInteractorOutput: AnyObject {
    func didLoadCurrentCount(_ count: Int)
    func didUpdateCount(_ count: Int)
}

// PRESENTER talks to ROUTER
protocol CounterRouterInput: AnyObject {
    func showAbout()
}
