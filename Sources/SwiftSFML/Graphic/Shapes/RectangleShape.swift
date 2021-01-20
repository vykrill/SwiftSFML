//
//  RectangleShape.swift
//  SwiftSFML
//
//  Created by Jérémy Goyette on 2021-01-18.
//

import Foundation

/// A rectangular shape.
public struct RectangleShape: Drawable {
    public var vertices: [Vertex] {
        didSet {
            if self.vertices.count != 4 {
                self.vertices = oldValue
            }
        }
    }
    
    public var transformations = TransformHandler()
    public var texture: Texture?
    
    public let type: PrimitiveType = .quads
    
    public var rect: RectF {
        get { self.bounds }
        set {
            self.vertices[0].position = Vector2F(x: newValue.left, y: newValue.top)
            self.vertices[1].position = Vector2F(x: newValue.left + newValue.width, y: newValue.top)
            self.vertices[2].position = Vector2F(x: newValue.left + newValue.width, y: newValue.top + newValue.height)
            self.vertices[3].position = Vector2F(x: newValue.left, y: newValue.top + newValue.height)
        }
    }
    
    public init(rect: RectF, textureRect: RectF = RectF(left: 0, top: 0, width: 32, height: 32), color: Color = .white) {
        self.vertices = [
            Vertex(position: Vector2F(x: rect.left, y: rect.top), color: color, texCoords: Vector2F(x: textureRect.left, y: textureRect.top)),
            Vertex(position: Vector2F(x: rect.left + rect.width, y: rect.top), color: color, texCoords: Vector2F(x: textureRect.left + textureRect.width, y: textureRect.top)),
            Vertex(position: Vector2F(x: rect.left + rect.width, y: rect.top + rect.height), color: color, texCoords: Vector2F(x: textureRect.left + textureRect.width, y: textureRect.top + textureRect.height)),
            Vertex(position: Vector2F(x: rect.left, y: rect.top + rect.height), color: color, texCoords: Vector2F(x: textureRect.left, y: textureRect.top + textureRect.height))
        ]
    }
}
