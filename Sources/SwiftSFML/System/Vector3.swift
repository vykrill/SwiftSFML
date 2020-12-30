// Vector3.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

public typealias Vector3F = sfVector3f

extension Vector3F: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}