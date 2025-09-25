//
//  CounterView.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 25/9/25.
//

import UIKit

final class RxCounterViewController: UIViewController {
    private let store: Store<CounterState, CounterAction>
    private var subscription: AnyObject?

    private let valueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .monospacedDigitSystemFont(ofSize: 56, weight: .bold)
        lbl.textAlignment = .center
        lbl.adjustsFontForContentSizeCategory = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let incButton = RxCounterViewController.makeButton(title: "Increment")
    private let decButton = RxCounterViewController.makeButton(title: "Decrement")
    private let resetButton = RxCounterViewController.makeButton(title: "Reset")

    init(store: Store<CounterState, CounterAction>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        title = "Redux Counter"
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Layout
        let buttonStack = UIStackView(arrangedSubviews: [decButton, resetButton, incButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        let vstack = UIStackView(arrangedSubviews: [valueLabel, buttonStack])
        vstack.axis = .vertical
        vstack.spacing = 24
        vstack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(vstack)
        NSLayoutConstraint.activate([
            vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vstack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vstack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            vstack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            valueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])

        // Actions
        incButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        decButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)

        // Subscribe to state updates
        subscription = store.subscribe { [weak self] state in
            self?.valueLabel.text = "\(state.value)"
        }
    }

    @objc private func increment() { store.dispatch(.increment) }
    @objc private func decrement() { store.dispatch(.decrement) }
    @objc private func reset()     { store.dispatch(.reset) }

    private static func makeButton(title: String) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        b.backgroundColor = .systemBlue
        b.tintColor = .white
        b.layer.cornerRadius = 12
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }
}
