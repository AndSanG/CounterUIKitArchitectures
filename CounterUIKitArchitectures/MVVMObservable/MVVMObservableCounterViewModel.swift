//
//  MVVMObservableCounterViewModel.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation
/*
 UIKit uses a tiny Box<T> wrapper to enable closure-based data binding.
 The ViewModel expose values that notify the ViewController automatically whenever they change
 */
final class MVVMObservableCounterViewModel {
    //MARK: Model
    private var counter: Counter
    //MARK: Box data biding
    let displayText: Box<String>

    init(counter: Counter = Counter(value: 3)) {
        self.counter = counter
        self.displayText = Box(.init(Self.formattedDisplayText(for: counter)))
    }
    
    // when value increments update the model and viewModel values
    func increment() {
        counter.value += 1
        displayText.value = .init(Self.formattedDisplayText(for: counter))
    }
    
    // util
    private static func formattedDisplayText(for counter: Counter) -> String {
        "Counter with MVVM Observable: \(counter.value)"
    }
}
