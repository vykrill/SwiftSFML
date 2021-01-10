// VertexArrayProtocol.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

/// Defines simple geometry that can be drawn in `RenderWindow`.
public protocol VertexArray {
    /// The vertices composing the object.
    var vertices: [Vertex] { get }
    /// How vertices are linked together.
    var type: PrimitiveType { get }
}