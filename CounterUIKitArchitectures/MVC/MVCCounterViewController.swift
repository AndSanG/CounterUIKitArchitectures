//
//  MVCCounterViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import UIKit

class MVCCounterViewController: UIViewController {
    //MARK: Model
    private var counter = Counter()
    //MARK: View
    private let counterView = CounterView()
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(counterView)
        counterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        counterView.update(with: counter.value)
        counterView.button.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
    }
    
    // On user action
    @objc private func incrementTapped() {
        // Update model
        counter.value += 1
        // Change the view
        counterView.update(with: counter.value)
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

