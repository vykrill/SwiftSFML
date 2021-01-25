// Time.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import Foundation
import CSFML

/// Represents a time value.
public typealias Time = sfTime

// MARK - Additionnal Values
extension Time {
    /// Predefined "zero" time value.
    public static let zero = sfTime_Zero
    /// The time value in seconds.
    public var seconds: Float { sfTime_asSeconds(self) }
    /// The time value in milliseconds.
    public var milliseconds: Int32 { sfTime_asMilliseconds(self)}

    /// Creates a new time value from a number of seconds.
    ///
    /// - parameter seconds: A number of seconds.
    public init(seconds: Float) {
        self = sfSeconds(seconds)
    }

    /// Creates a new time value from a number of milliseconds.
    /// - parameter milliseconds: A number of milliseconds.
    public init(milliseconds: Int32) {
        self = sfMilliseconds(milliseconds)
    }
}

// MARK - Equatable and Comparable
extension Time: Equatable, Comparable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.microseconds == rhs.microseconds
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.microseconds < rhs.microseconds
    }
}

// MARK - String Conversion
extension Time: CustomDebugStringConvertible {
    public var debugDescription: String { "\(self.microseconds)" }
}
