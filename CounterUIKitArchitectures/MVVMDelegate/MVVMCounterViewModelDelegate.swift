//
//  MVVMCounterViewModelDelegate.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

import Foundation
// One clear direction for user intents: VC → VM (methods); state updates: VM → VC (delegate).
protocol MVVMCounterViewModelDelegate: AnyObject {
    func counterViewModel(_ viewModel: MVVMDelegateCounterViewModel, didUpdate displayText: String)
}
