// Transformable.swift
// Created by Jérémy Goyette
// On 2021/01/20
// For SwiftSFML

import CSFML

/// Allow a type to be transformed in variou ways.
///
/// - note: The gained properties and methods are mostly calls to their `TransformHandler` counterpart.
public protocol Transformable {
    /// The property handling the transformations.
    var transformations: TransformHandler { get set }
}

public extension Transformable {
    /// The inverse of the combined transform of the object.
    var inverseTransform: Transform {
        self.transformations.inverseTransform
    }

    /// The origin of all transformations.
    ///
    /// The origin of an object defines the center point for all transformations (position, scale, rotation).
    /// The coordinates of this point must be relative to the top-left corner of the object, and ignore all
    /// transformations (position, scale, rotation). The default origin of a transformable object is (0, 0).
    var origin: Vector2F {
        get { self.transformations.origin }
        set { self.transformations.origin = newValue }
    }

    /// The current position.
    var position: Vector2F {
        get { self.transformations.position }
        set { self.transformations.position = newValue }
    }

    /// The current rotation.
    var rotation: Float {
        get { self.transformations.rotation }
        set { self.transformations.rotation = newValue }
    }

    /// The current scale on the X and Y axis.
    var scale: Vector2F {
        get { self.transformations.scale }
        set { self.transformations.scale = newValue }
    }

    /// The combined transform of the object. 
    var transform: Transform {
        self.transformations.transform
    }

    // MARK: Methods

    /// Rotates the object.
    ///
    /// This function adds to the current rotation of the object.
    /// - parameter angle: The angle of rotation, in degrees.
    func rotate(by angle: Float) {
        self.transformations.rotate(by: angle)
    }

    /// Scale the object.
    ///
    /// This function adds to the current scaling.
    /// - parameter factors: The factors of scaling on the X and Y axis.
    func scale(by factors: Vector2F) {
        self.transformations.scale(by: factors)
    }

    /// Moves the object by a given object.
    ///
    /// - parameter offset: The offset to apply.
    func translate(by offset: Vector2F) {
        self.transformations.translate(by: offset)
    }
}