//
//  Calculator.swift
//  calc
//
//  Created by Tastthai Khainjai on 13/3/2569 BE.
//  Copyright © 2569 BE UTS. All rights reserved.
//

import Foundation

class Calculator {
    var op: String
    var number: [Int]
    init(op: String, number: [Int]) {
        self.op = op
        self.number = number
    }
    func add (num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
}
