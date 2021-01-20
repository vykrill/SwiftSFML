// Drawable.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

/// Defines an object that can be drawn in a `RenderWindow`.
///
/// By opposition to a simple `VertexArray`, `Drawable` stores a texture and its transforms. This eliminates the need
/// for passing a `RenderState` instance in the `draw` function.
public protocol Drawable: VertexArray {
    /// The texture of the object.
    var texture: Texture? { get }
    /// The transformations that will be applied to the object when drawn.
    var transform: Transform { get set }
    /// The default origin of the transformations.
    var origin: Vector2F { get }
}

extension Drawable {
    /// Returns the bounds of the object in world space.
    public func getGlobalBounds() -> RectF {
        return self.transformed().bounds
    }

    /// Translates `self` by the given offset.
    ///
    /// - parameter offset: The offset to apply.
    public mutating func translate(by offset: Vector2F) {
        self = self.translated(by: offset)
    }

    /// Creates a translated copy of the `self`.
    ///
    /// - parameter offset: The offset to apply.
    /// - returns: A translated copy of self.
    public func translated(by offset: Vector2F) -> Self {
        var copy = self
        copy.transform.translate(by: offset)
        return copy
    }

    /// Scale `self` by the given factors.
    ///
    /// - parameters:
    ///     - factors: The scale factors on the X and Y axis.
    ///     - center: The center of the scaling. Leave to `nil` to use the object's origin.
    public mutating func scale(by factors: Vector2F, withCenter center: Vector2F? = nil) {
        self = self.scaled(by: factors, withCenter: center)
    }

    /// Creates a scaled copy of `self`.
    ///
    /// - parameters:
    ///     - factors: The scale factors on the X and Y axis.
    ///     - center: The center of the scaling. Leave to `nil` to use the object's origin.
    ///
    /// - returns: A copy of `self`, scaled by the given factors.
    public func scaled(by factors: Vector2F, withCenter center: Vector2F? = nil) -> Self {
        var copy = self
        copy.transform.scale(by: factors, withCenter: center ?? self.origin)
        return copy
    }

    /// Rotates `self`.
    ///
    /// - parameter angle: The angle of rotation in degrees.
    /// - parameter center: The center of rotation. Leave to `nil` to use the object's origin.
    public mutating func rotate(by angle: Float, withCenter center: Vector2F? = nil) {
        self = self.rotated(by: angle, withCenter: center)
    }

    /// Creates a rotated copy of `self`.
    ///
    /// - parameters:
    ///     - angle: The angle of rotation in degrees.
    ///     - center: The center of rotation. Leave to `nil` to use the object's origin.
    ///
    /// - returns: A copy of `self` rotated by the given angle.
    public func rotated(by angle: Float, withCenter center: Vector2F? = nil) -> Self {
        var copy = self
        copy.transform.rotate(by: angle, withCenter: center ?? self.origin)
        return copy
    }

    /// Recalculate the texture coordinates of each vertices.
    ///
    /// By default, it covers the whole texture with the bounding box of the object. If this behavior doesn't suit
    /// you, you can always implement your own version in your custom types.
    public mutating func resetTextureRect() {
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

        transformed.transform = .identity

        return transformed
    }

    /// Applies the transformations of the object on `self`.
    public mutating func applyTransform() {
        self = self.transformed()
    }
    
}
