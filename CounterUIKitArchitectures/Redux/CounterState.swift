//
//  CounterState.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 25/9/25.
//

import Foundation

typealias CounterState = Counter

extension CounterState {
    var reduxFormatted: String {
        return "Count with Redux: \(value)"
    }
}
