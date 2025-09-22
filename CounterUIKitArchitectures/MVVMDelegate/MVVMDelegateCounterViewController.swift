//
//  MVVMDelegateCounterViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import UIKit

class MVVMDelegateCounterViewController: UIViewController, MVVMCounterViewModelDelegate {

    //MARK: View
    private let counterView = CounterView()
    //MARK: View Model
    private let viewModel = MVVMDelegateCounterViewModel()
    
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
        
        viewModel.attach(self)
    }
    
    @objc private func incrementTapped() {
        viewModel.increment()
    }
    
    // Delegate callback
    func counterViewModel(_ viewModel: MVVMDelegateCounterViewModel, didUpdate displayText: String) {
        counterView.text = displayText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
