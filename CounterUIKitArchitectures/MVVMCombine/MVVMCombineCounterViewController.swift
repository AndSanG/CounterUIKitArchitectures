//
//  MVVMCombineCounterViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import UIKit
import Combine

class MVVMCombineCounterViewController: UIViewController {
    
    //MARK: View
    private let counterView = CounterView()
    //MARK: View Model
    private let viewModel = MVVMCombineCounterViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterView.buttonTitle = "Increment"
        counterView.action = { [weak self] in
            self?.incrementTapped()
        }
        
        view.addSubview(counterView)
        counterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // The view changes con binded variable change
        // Bind ViewModel -> View
        viewModel.$displayText
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                self?.counterView.text = text
            }
            .store(in: &cancellables)
    }
    
    @objc private func incrementTapped() {
        viewModel.increment()
    }
}
