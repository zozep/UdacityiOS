//
//  CounterModel.swift
//  Counter
//
//  Created by Jarrod Parkes on 11/25/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

// MARK: - CounterModel

/// Used to count up or down.
struct CounterModel {
    /// Only this struct can adjust the value
    var value: String = ""
    
    mutating func increment() {
        value += "❤️"
    }
    
    mutating func decrement() {
        if !value.isEmpty {
            value.remove(at: value.index(before: value.endIndex))
        } else {
            value = ""
        }
    }
}
