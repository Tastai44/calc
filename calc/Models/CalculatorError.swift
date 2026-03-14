//
//  CalculatorError.swift
//  calc
//
//  Created by Tastthai Khainjai on 13/3/2569 BE.
//  Copyright © 2569 BE UTS. All rights reserved.
//
//  Defines all possible errors that can be thrown during calculation.
//  Conforms to LocalizedError to provide user-friendly error messages.
//

import Foundation

/// Represents all errors that can occur during a calculator operation.
///
/// Conforms to `LocalizedError` so each case can surface a descriptive
/// message suitable for display to the end user.
enum CalculatorError: Error, LocalizedError {

    /// Thrown when the number of arguments provided is zero or even.
    /// A valid expression requires an odd count: `number op number [op number ...]`
    case invalidArgumentCount

    /// Thrown when a string argument cannot be parsed as an `Int`.
    /// - Parameter value: The string that failed to parse.
    case invalidInteger(String)

    /// Thrown when an operator symbol is not recognised by the calculator.
    /// - Parameter op: The unrecognised operator string.
    case unsupportedOperator(String)

    /// Thrown when a division or modulus operation is attempted with a divisor of zero.
    case divisionByZero

    /// Thrown when an arithmetic operation produces a result outside the range of `Int`.
    case numericOutOfBounds

    /// A human-readable description of the error, suitable for display to the user.
    var errorDescription: String? {
        switch self {
        case .invalidArgumentCount:
            return "Usage: <number1> <operator> <number2>\nExample: 5 + 10"
        case .invalidInteger(let value):
            return "Error: '\(value)' is not a valid integer."
        case .unsupportedOperator(let op):
            return "Error: Operator '\(op)' is not supported."
        case .divisionByZero:
            return "Error: Division by zero is not allowed."
        case .numericOutOfBounds:
            return "Error: Calculation resulted in an integer overflow or underflow."
        }
    }
}
