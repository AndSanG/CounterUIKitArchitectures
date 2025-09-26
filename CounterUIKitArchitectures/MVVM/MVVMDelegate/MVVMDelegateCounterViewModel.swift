//
//  MVVMDelegateCounterViewModel.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation
final class MVVMDelegateCounterViewModel {
    weak var delegate: MVVMCounterViewModelDelegate?
    private var counter = Counter(value: 4)

    // initialize the delegate.
    func attach(_ delegate: MVVMCounterViewModelDelegate) {
        self.delegate = delegate
        notify()
    }
    
    // changes the model
    func increment() {
        counter.value += 1
        notify()
    }
    
    // tells the delegate to update the values
    private func notify() {
        delegate?.counterViewModel(self, didUpdate: .init(Self.formattedDisplayText(for: counter)))
    }
    
    // util
    private static func formattedDisplayText(for counter: Counter) -> String {
        "Counter with MVVM Delegate: \(counter.value)"
    }
}
