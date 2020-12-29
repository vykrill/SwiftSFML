// Time.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import Foundation
import CSFML

/// Represents a time value.
public typealias Time = sfTime

extension Time: Equatable, Comparable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.microseconds == rhs.microseconds
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.microseconds < rhs.microseconds
    }
}