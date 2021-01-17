// Drawable.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

public protocol Drawable: VertexArray {
    var texture: Texture? { get }
    var transform: Transform { get set }
    var origin: Vector2F { get }
}

extension Drawable {

    mutating func translate(by offset: Vector2F) {
        self.transform.translate(by: offset)
    }

    mutating func scale(by factors: Vector2F) {
        self.transform.scale(by: factors, withCenter: origin)
    }

    mutating func rotate(by angle: Float) {
        self.transform.rotate(by: angle, withCenter: origin)
    }

    mutating func resetTextureRect() {
        guard let size = self.texture?.size else {
            return
        }

        for index in self.vertices.indices {
            self.vertices[index].texCoords = Vector2F(
                x: (self.vertices[index].position.x * Float(size.x)) / self.bounds.width,
                y: (self.vertices[index].position.y * Float(size.y)) / self.bounds.height
            )
        }
    }
    
}