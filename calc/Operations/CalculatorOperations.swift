//
//  CalculatorOperations.swift
//  calc
//
//  Created by Tastthai Khainjai on 13/3/2569 BE.
//  Copyright © 2569 BE UTS. All rights reserved.
//
//  Extension on Calculator that implements each individual arithmetic operation.
//  Each method uses Swift's overflow-reporting variants to detect out-of-bounds results.
//

import Foundation

extension Calculator {

    /// Multiplies two integers, throwing if the result overflows `Int`.
    ///
    /// - Parameters:
    ///   - no1: The left-hand operand.
    ///   - no2: The right-hand operand.
    /// - Returns: The product of `no1` and `no2`.
    /// - Throws: `CalculatorError.numericOutOfBounds` if the result exceeds `Int` range.
    func multiply(no1: Int, no2: Int) throws -> Int {
        let (result, overflow) = no1.multipliedReportingOverflow(by: no2)
        guard !overflow else { throw CalculatorError.numericOutOfBounds }
        return result
    }

    /// Divides `no1` by `no2`, throwing on division by zero or overflow.
    ///
    /// Overflow can occur in the edge case of `Int.min / -1`.
    ///
    /// - Parameters:
    ///   - no1: The dividend.
    ///   - no2: The divisor. Must not be zero.
    /// - Returns: The integer quotient of `no1 / no2`.
    /// - Throws: `CalculatorError.divisionByZero` if `no2` is `0`.
    /// - Throws: `CalculatorError.numericOutOfBounds` if the result overflows.
    func divide(no1: Int, no2: Int) throws -> Int {
        guard no2 != 0 else { throw CalculatorError.divisionByZero }
        let (result, overflow) = no1.dividedReportingOverflow(by: no2)
        guard !overflow else { throw CalculatorError.numericOutOfBounds }
        return result
    }

    /// Returns the remainder of dividing `no1` by `no2`.
    ///
    /// - Parameters:
    ///   - no1: The dividend.
    ///   - no2: The divisor. Must not be zero.
    /// - Returns: The remainder of `no1 % no2`.
    /// - Throws: `CalculatorError.divisionByZero` if `no2` is `0`.
    /// - Throws: `CalculatorError.numericOutOfBounds` if the operation overflows.
    func modulus(no1: Int, no2: Int) throws -> Int {
        guard no2 != 0 else { throw CalculatorError.divisionByZero }
        let (result, overflow) = no1.remainderReportingOverflow(dividingBy: no2)
        guard !overflow else { throw CalculatorError.numericOutOfBounds }
        return result
    }

    /// Adds two integers, throwing if the result overflows `Int`.
    ///
    /// This is also used internally to sum the number stack at the end of evaluation.
    ///
    /// - Parameters:
    ///   - no1: The first addend.
    ///   - no2: The second addend.
    /// - Returns: The sum of `no1` and `no2`.
    /// - Throws: `CalculatorError.numericOutOfBounds` if the result exceeds `Int` range.
    func add(no1: Int, no2: Int) throws -> Int {
        let (result, overflow) = no1.addingReportingOverflow(no2)
        guard !overflow else { throw CalculatorError.numericOutOfBounds }
        return result
    }

    /// Negates an integer so it can be pushed onto the stack for deferred addition.
    ///
    /// Subtraction is handled by negating the right-hand operand and adding it later,
    /// preserving left-to-right evaluation order across the whole expression.
    ///
    /// - Parameter no: The integer to negate.
    /// - Returns: The negated value (`0 - no`).
    /// - Throws: `CalculatorError.numericOutOfBounds` if negating `Int.min` overflows.
    func minusNumber(no: Int) throws -> Int {
        let (negatedNumber, overflow) = 0.subtractingReportingOverflow(no)
        guard !overflow else { throw CalculatorError.numericOutOfBounds }
        return negatedNumber
    }
}
