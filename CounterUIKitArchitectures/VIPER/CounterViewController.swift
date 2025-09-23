//
//  CounterViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import UIKit

final class CounterViewController: UIViewController, CounterViewInput {
    
    var output: CounterViewOutput!
    
    private let counterView = CounterView()
    private let resetButton = UIButton(type: .system)
    private let aboutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        counterView.buttonTitle = "Increment"
        resetButton.setTitle("Reset", for: .normal)
        aboutButton.setTitle("About", for: .normal)

        counterView.action = { [weak self] in self?.didTapIncrement()}
        resetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
        aboutButton.addTarget(self, action: #selector(didTapAbout), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [counterView, resetButton, aboutButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        output.viewDidLoad()
    }

    // View -> Presenter
    @objc private func didTapIncrement() { output.didTapIncrement() }
    @objc private func didTapReset() { output.didTapReset() }
    @objc private func didTapAbout() { output.didTapAbout() }

    // Presenter -> View
    func render(countText: String, isResetEnabled: Bool) {
        counterView.text = countText
        resetButton.isEnabled = isResetEnabled
    }
}
