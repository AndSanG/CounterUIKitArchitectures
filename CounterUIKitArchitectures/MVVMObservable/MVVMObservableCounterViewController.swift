//
//  MVVMObservableCounterViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import UIKit

class MVVMObservableCounterViewController: UIViewController {
    
    //MARK: View
    private let counterView = CounterView()
    //MARK: ViewModel
    private let viewModel = MVVMObservableCounterViewModel()
    
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
        // When the viewModel value changes the listener is executed
        // Bind ViewModel -> View
        viewModel.displayText.bind { [weak self] displayText in
            self?.counterView.text = displayText
        }
        
    }
    
    @objc private func incrementTapped() { viewModel.increment() }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
