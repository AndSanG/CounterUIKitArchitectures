//
//  MVVMCombineCounterModelView.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import Foundation
import Combine

class MVVMCombineCounterViewModel: ObservableObject {
    //Ready to display values
    @Published private(set) var displayText: String
    //Model
    private var counter: Counter
    
    init(counter: Counter = Counter(value: 2)) {
        self.counter = counter
        displayText = Self.formattedDisplayText(for: counter)
    }
    
    // update the model
    func increment() {
        counter.value += 1
        displayText = Self.formattedDisplayText(for: counter)
    }
    
    // util
    private static func formattedDisplayText(for counter: Counter) -> String {
        "Counter with MVVM Combine: \(counter.value)"
    }
}
