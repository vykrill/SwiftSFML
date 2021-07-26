// Vector3.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

public typealias Vector3F = sfVector3f

extension Vector3F: Equatable, AdditiveArithmetic {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    public static let zero = Vector3F(x: 0, y: 0, z: 0)

    public static func +(l: Self, r: Self) -> Self {
        Self(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z)
    }

    public static func -(l: Self, r: Self) -> Self {
        Self(x: l.x - r.x, y: l.y - r.y, z: l.z - r.z)
    }
}