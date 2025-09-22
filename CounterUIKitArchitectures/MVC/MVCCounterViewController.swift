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
    
    //MARK: VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        counterView.text = formattedDisplayText(with: counter)
        counterView.buttonTitle = "Increment"
        view.addSubview(counterView)
        counterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        counterView.action = { [weak self] in
            self?.incrementTapped()
        }
    }
    
    // On user action
    @objc private func incrementTapped() {
        // Update model
        counter.value += 1
        // Change the view
        counterView.text = formattedDisplayText(with: counter)
    }
    
    private func formattedDisplayText(with counter: Counter) -> String{
        "Counter with MVC: \(counter.value)"
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
