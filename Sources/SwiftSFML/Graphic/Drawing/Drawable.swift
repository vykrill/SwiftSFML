// Drawable.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

/// Defines an object that can be drawn in a `RenderWindow` or `RenderTarget`.
///
/// By opposition to a simple `VertexArray`, `Drawable` stores a texture and its transforms. This eliminates the need
/// for passing a `RenderState` instance in the `draw` function.
///
/// Creating a type conforming to `Drawable` is quite simple:
///
///     public struct Shape: Drawable {
///         public var vertices: [Vertex] = ...
///         public let type: PrimitiveType = ...
///         public var transformations = TransformHandler()
///         public var texture: Texture?
///     }
///
///     let shape = Shape()
///
/// All you need to do inside your Type is to position correctly the vertices in local space. You can also override `getTextureCoordinate(for:, textureRect: )` in order to customise
/// The texture mapping. Conforming to `Drawable`gives your type access to transforms and drawing.
///
///     shape.scale(by: Vector2F(x: 2, y: 2)
///     shape.texture = myTexture
///     shape.setTextureRect(to: RectF(left: 0, top: 0, width: 64, height: 64))
///
///     window.draw(shape)
///
public protocol Drawable: VertexArray, Transformable {
    
    /// The texture of the object.
    var texture: Texture? { get }
    
    /// Calculates the new texture coordinate of a vertex.
    /// 
    /// This function is responsible for calculating the texture coordinate of each vertex when the `resetTextureRect` and
    /// `setTextureRect(to:)` methods are called. By default, it sets the texture coordinate to a position relative to
    /// the position of the vertex in the vertex array. As a result, the vertex array covers as much of the texture as it
    /// can. 
    ///
    /// If this behavior is not suitable for your purpose, you can override it in your custom types.
    ///
    /// - parameters:
    ///     - vertex: The vertex for which a new texture coordinate is needed.
    ///     - index: The index of the current vertex. Usefull when some vertices can overlap.
    ///     - rect: The new texture rect that will be applied.
    ///
    /// - returns: The corresponding texture coordinate for `vertex`.
    func getTextureCoordinate(for vertex: Vertex, atIndex index: Int, textureRect rect: RectF) -> Vector2F
}

extension Drawable {
    /// Returns the bounds of the object in world space.
    public func getGlobalBounds() -> RectF {
        return self.transformed().bounds
    }

    /// Creates a translated copy of the `self`.
    ///
    /// - parameter offset: The offset to apply.
    /// - returns: A translated copy of self.
    public func translated(by offset: Vector2F) -> Self {
        let copy = self
        copy.translate(by: offset)
        return copy
    }

    /// Creates a scaled copy of `self`.
    ///
    /// - parameters:
    ///     - factors: The scale factors on the X and Y axis.
    ///     - center: The center of the scaling. Leave to `nil` to use the object's origin.
    ///
    /// - returns: A copy of `self`, scaled by the given factors.
    public func scaled(by factors: Vector2F, withCenter center: Vector2F? = nil) -> Self {
        let copy = self
        copy.scale(by: factors)
        return copy
    }

    /// Creates a rotated copy of `self`.
    ///
    /// - parameters:
    ///     - angle: The angle of rotation in degrees.
    ///     - center: The center of rotation. Leave to `nil` to use the object's origin.
    ///
    /// - returns: A copy of `self` rotated by the given angle.
    public func rotated(by angle: Float, withCenter center: Vector2F? = nil) -> Self {
        let copy = self
        copy.rotate(by: angle)
        return copy
    }

    /// Fits the current texture rect to the size of the texture.
    ///
    /// This function uses the `getTextureCoordinate(for:, textureRect:)` to calculates the new texture coordinates
    /// with a texture rect of (0, 0, texture.width, texture.height). If `texture` is set to `nil`, this method does nothing.
    public mutating func resetTextureRect() {
        guard let size = self.texture?.size else {
            return
        }

        self.setTextureRect(to: RectF(left: 0, top: 0, width: Float(size.x), height: Float(size.y)))
    }

    /// Sets a new texture rect to the object.
    ///
    /// This method uses the `getTextureCoordinate(for:, textureRect:)` function for each vertex.
    /// - parameter rect: The new texture rect to apply.
    public mutating func setTextureRect(to rect: RectF) {
        for index in self.vertices.indices {
            self.vertices[index].texCoords = self.getTextureCoordinate(for: vertices[index], atIndex: index, textureRect: rect)
        }
    }

    public func getTextureCoordinate(for vertex: Vertex, atIndex: Int, textureRect rect: RectF) -> Vector2F {
        Vector2F(
            x: (vertex.position.x * rect.width) / self.bounds.width + rect.left,
            y: (vertex.position.y * rect.height) / self.bounds.height + rect.top
        )
    }

    /// Creates a transformed copy of `self`.
    ///
    /// Unlike `rotated`, `scaled` or `translated`, this function applies the transformation to each vertices of the copy.
    /// It is simlar to creating a copy of the current object and using `applyTransform` on it.
    ///
    /// - returns: A copy of `self` where all vertices have been transformed.
    public func transformed() -> Self {
        var transformed = self
        transformed.vertices = self.vertices.map { 
            var newPoint = $0
            newPoint.position = self.transform.transform($0.position)
            return newPoint 
        }

        transformed.transformations = TransformHandler()

        return transformed
    }

    /// Applies the transformations of the object on `self`.
    public mutating func applyTransform() {
        self = self.transformed()
    }
    
}
