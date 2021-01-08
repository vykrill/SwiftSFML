// Transform.swift
// Created by Jérémy Goyette
// On 2021/01/04
// For SwiftSFML

import CSFML

public typealias Transform = sfTransform

extension Transform: ExpressibleByArrayLiteral, Equatable {
    /// Creates a Transform instance from an array-expressed 3x3 matrix.
    ///
    ///     let identity: Transform = [
    ///         1.0, 0.0, 0.0,
    ///         0.0, 1.0, 0.0,
    ///         0.0, 0.0, 1.0
    ///     ]
    ///
    /// - parameter elements: The elements composisng the matrix. There must be exactly 9 of them.
    public init(arrayLiteral elements: Float...) {
        assert(elements.count == 9, "The array used to create a Transform instance must have 9 elements.")
        self = sfTransform_fromMatrix(
            elements[0], elements[1], elements[2],
            elements[3], elements[4], elements[5],
            elements[6], elements[7], elements[8]
        )
    }

    /// Creates a identity transform.
    public init() {
        self = .identity
    }

    public typealias ArrayLiteralElement = Float

    /// Return the inverse of a transform. 
    ///
    /// If no inverse can be computed, it is an identity transform.
    public var inverse: Transform {
        var temp = self
        return sfTransform_getInverse(&temp)
    }

    /// The 4x4 matrix of a transform.
    ///
    /// An array of 16 floats with the transform converted as a 4x4 matrix, 
    /// which is directly compatible with OpenGL functions.
    public var matrix4: [Float] {
        var tempSelf = self
        var matrix = [Float](repeating: 0, count: 16)
        sfTransform_getMatrix(&tempSelf, &matrix)
        return matrix
    }

    /// Combine the current transform with a rotation.
    ///
    /// - parameter angle: Rotation angle, in degrees.
    public mutating func rotate(by angle: Float) {
        sfTransform_rotate(&self, angle)
    }

    /// Combine the current transform with a rotation.
    ///
    /// The center of rotation is provided for convenience as a second argument, so that you can build rotations around
    /// arbitrary points more easily (and efficiently) than the usual [translate(-center), rotate(angle),
    /// translate(center)].
    ///
    /// - parameters:
    ///     - angle: Angle of rotation in degrees.
    ///     - center: The center of rotation.
    public mutating func rotate(by angle: Float, withCenter center: Vector2F) {
        sfTransform_rotateWithCenter(&self, angle, center.x, center.y)
    } 
    
    /// Combine the current transform with a scaling. 
    ///
    /// - parameter scale: The scaling factors.
    public mutating func scale(by scale: Vector2F) {
        sfTransform_scale(&self, scale.x, scale.y)
    }

    /// Combine the current transform with a scaling.
    /// 
    /// The center of scaling is provided for convenience as a second argument, so that you can build scaling around
    /// arbitrary points more easily (and efficiently) than the usual [translate(-center), scale(factors),
    /// translate(center)]
    public mutating func scale(by scale: Vector2F, withCenter center: Vector2F) {
        sfTransform_scaleWithCenter(&self, scale.x, scale.y, center.x, center.y)
    }

    /// Apply a transform to a 2D point. 
    ///
    /// - parameter point: The point to transform.
    /// - returns: The transformed point.
    public func transform(_ point: Vector2F) -> Vector2F {
        var tempSelf = self
        return sfTransform_transformPoint(&tempSelf, point)
    }

    /// Apply a transform to a rectangle.
    ///
    /// Since SFML doesn't provide support for oriented rectangles, the result of this function is always an
    /// axis-aligned rectangle. Which means that if the transform contains a rotation, the bounding rectangle of the
    /// transformed rectangle is returned.
    ///
    /// - parameter rect: The rectangle to transform.
    /// - returns: The transformed rectangle.
    public func transform(_ rect: RectF) -> RectF {
        var tempSelf = self
        return sfTransform_transformRect(&tempSelf, rect)
    }

    /// Combine a transform with a translation. 
    ///
    /// - parameter offset: The offset to apply.
    public mutating func translate(by offset: Vector2F) {
        sfTransform_translate(&self, offset.x, offset.y)
    }

    // MARK: Static members
    /// Identity transform (does nothing).
    public static let identity = sfTransform_Identity

    static public func ==(lhs: Self, rhs: Self) -> Bool {
        return (
            (lhs.matrix.0 == rhs.matrix.0) &&
            (lhs.matrix.1 == rhs.matrix.1) &&
            (lhs.matrix.2 == rhs.matrix.2) &&
            (lhs.matrix.3 == rhs.matrix.3) &&
            (lhs.matrix.4 == rhs.matrix.4) &&
            (lhs.matrix.5 == rhs.matrix.5) &&
            (lhs.matrix.6 == rhs.matrix.6) &&
            (lhs.matrix.7 == rhs.matrix.7) &&
            (lhs.matrix.8 == rhs.matrix.8)
        )
    }
}