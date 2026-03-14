//
//  Calculator.swift
//  calc
//
//  Created by Tastthai Khainjai on 13/3/2569 BE.
//  Copyright © 2569 BE UTS. All rights reserved.
//
//  Core orchestration logic for the calculator.
//  Parses a flat array of string tokens and evaluates the expression
//  using a number stack to respect operator precedence for * / %
//  while deferring + and - to a final summation pass.
//

import Foundation

class Calculator {

    /// Parses and evaluates a mathematical expression passed as a token array.
    ///
    /// The expression must follow the pattern:
    /// ```
    /// <number> <operator> <number> [<operator> <number> ...]
    /// ```
    /// Supported operators: `+`, `-`, `x`, `*`, `/`, `%`
    ///
    /// Multiplication, division, and modulus are evaluated immediately (higher precedence).
    /// Addition and subtraction are deferred by pushing values onto a stack,
    /// then summed in a final pass.
    ///
    /// - Parameter args: An array of string tokens representing the expression,
    ///   e.g. `["5", "+", "3", "*", "2"]`.
    /// - Returns: The integer result of evaluating the full expression.
    /// - Throws: `CalculatorError.invalidArgumentCount` if `args` is empty or has an even count.
    /// - Throws: `CalculatorError.invalidInteger` if any number token cannot be parsed.
    /// - Throws: `CalculatorError.unsupportedOperator` if an unknown operator is encountered.
    /// - Throws: `CalculatorError.divisionByZero` if a `/` or `%` has a zero right operand.
    /// - Throws: `CalculatorError.numericOutOfBounds` if any operation overflows `Int`.
    func calcProcess(args: [String]) throws -> Int {
        // Validate argument count: must be odd (e.g. 3 tokens for "a op b", 5 for "a op b op c")
        guard !args.isEmpty, args.count % 2 != 0 else {
            throw CalculatorError.invalidArgumentCount
        }

        // Parse the first token as the initial number
        guard let firstNumber = Int(args[0]) else {
            throw CalculatorError.invalidInteger(args[0])
        }

        // Stack accumulates operands; at the end they are all summed together
        var numberStack: [Int] = [firstNumber]

        // Iterate over (operator, operand) pairs starting at index 1
        for i in stride(from: 1, to: args.count, by: 2) {
            let op = args[i]

            // Parse the right-hand operand for the current operator
            guard let nextNumber = Int(args[i + 1]) else {
                throw CalculatorError.invalidInteger(args[i + 1])
            }

            switch op {
            case "x", "*":
                // Immediate evaluation: pop top, multiply, push result
                numberStack.append(try multiply(no1: numberStack.removeLast(), no2: nextNumber))

            case "/":
                // Immediate evaluation: pop top, divide, push result
                numberStack.append(try divide(no1: numberStack.removeLast(), no2: nextNumber))

            case "%":
                // Immediate evaluation: pop top, apply modulus, push result
                numberStack.append(try modulus(no1: numberStack.removeLast(), no2: nextNumber))

            case "+":
                // Deferred: push the positive number to be added in the final summation
                numberStack.append(nextNumber)

            case "-":
                // Deferred: push the negated number to be added in the final summation
                numberStack.append(try minusNumber(no: nextNumber))

            default:
                throw CalculatorError.unsupportedOperator(op)
            }
        }

        // Sum all values remaining on the stack to produce the final result
        return try numberStack.reduce(0) { try add(no1: $0, no2: $1) }
    }

    /// Entry point for evaluation. Converts the result to a `String` for output.
    ///
    /// - Parameter args: An array of string tokens representing the expression.
    /// - Returns: A string representation of the calculated integer result.
    /// - Throws: Any `CalculatorError` surfaced during parsing or evaluation.
    func calculate(args: [String]) throws -> String {
        return String(try calcProcess(args: args))
    }
}
