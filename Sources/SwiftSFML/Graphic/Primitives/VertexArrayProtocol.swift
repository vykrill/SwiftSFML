// VertexArrayProtocol.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

/// Defines simple geometry that can be drawn in `RenderWindow`.
public protocol VertexArray {
    /// The vertices composing the object.
    var vertices: [Vertex] { get set }
    /// How vertices are linked together.
    var type: PrimitiveType { get }
}

extension VertexArray {
    var size: Vector2F {
        let x = self.vertices.map({$0.position.x})
        let y = self.vertices.map({$0.position.y})
        
        return Vector2F(x: (x.max() ?? 0) - (x.min() ?? 0), y: (y.max() ?? 0) - (y.min() ?? 0))
    }

    var bounds: RectF {
        let x = self.vertices.map({$0.position.x})
        let y = self.vertices.map({$0.position.y})

        return RectF(
            left: x.min() ?? 0,
            top: y.min() ?? 0, 
            width: (x.max() ?? 0) - (x.min() ?? 0), 
            height: (y.max() ?? 0) - (y.min() ?? 0)
        )
    }
}