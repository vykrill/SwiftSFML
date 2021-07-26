// Vectors.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML
//
// The numerous vector structs provided by CSFML.

import CSFML

// MARK: Vector2I
/// Two-component vector of integers.
public typealias Vector2I = sfVector2i

extension Vector2I: Equatable, AdditiveArithmetic {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public static var zero = Self(x: 0, y: 0)

    public static func +(l: Self, r: Self) -> Self {
        Self(x: l.x + r.x, y: l.y + r.y)
    }

    public static func -(l: Self, r: Self) -> Self {
        Self(x: l.x - r.x, y: l.y - r.y)
    }
}

// Vector2U
/// Two-component vector of unsigned integers.
public typealias Vector2U = sfVector2u

extension Vector2U: Equatable, AdditiveArithmetic {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public static var zero = Self(x: 0, y: 0)


    public static func +(l: Self, r: Self) -> Self {
        Self(x: l.x + r.x, y: l.y + r.y)
    }

    public static func -(l: Self, r: Self) -> Self {
        Self(x: l.x - r.x, y: l.y - r.y)
    }
}

/// Two-component vector of floats.
public typealias Vector2F = sfVector2f

extension Vector2F: Equatable, AdditiveArithmetic {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public static var zero = Self(x: 0, y: 0)


    public init<Source: BinaryInteger>(x: Source, y: Source) {
        self.init(x: Float(x), y: Float(y))
    }

    public static func +(l: Self, r: Self) -> Self {
        Self(x: l.x + r.x, y: l.y + r.y)
    }

    public static func -(l: Self, r: Self) -> Self {
        Self(x: l.x - r.x, y: l.y - r.y)
    }
}