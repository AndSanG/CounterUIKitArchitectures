//
//  Box.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation
//Wrapper (Box<T>) around any type of value.
final class Box<T> {
    // called on change
    private var listener: ((T) -> Void)?
    //didSet: whenever value changes, the closure (listener) is called.
    var value: T { didSet { listener?(value) } }

    init(_ value: T) { self.value = value }
    
    // bind: ViewController registers a closure; it’s triggered on every change.
    func bind( listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value) // emit current value immediately
    }
}
