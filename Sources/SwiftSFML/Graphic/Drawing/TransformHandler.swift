// TransformHandler.swift
// Created by Jérémy Goyette
// On 2021/01/20
// For SwiftSFML

import CSFML

/// Decomposed transform defined by a position, a rotation and a scale. 
///
/// This class is provided for convenience, on top of `Transform`.
/// 
/// `Transform`, as a low-level struct, offers a great level of flexibility but it is not always convenient to manage. 
/// Indeed, one can easily combine any kind of operation, such as a translation followed by a rotation followed by a
/// scaling, but once the result transform is built, there's no way to go backward and, let's say, change only the
/// rotation without modifying the translation and scaling. The entire transform must be recomputed, which means that you
/// need to retrieve the initial translation and scale factors as well, and combine them the same way you did before
/// updating the rotation. This is a tedious operation, and it requires to store all the individual components of the
/// final transform.
/// 
/// That's exactly what `TransformHandler` was written for: it hides these variables and the composed transform behind
/// an easy to use interface. You can set or get any of the individual components without worrying about the others. It
/// also provides the composed transform (as a `Transform`), and keeps it up-to-date.
/// 
/// In addition to the position, rotation and scale, `TransformHandler` provides an `origin` component, which represents
/// the local origin of the three other components. Let's take an example with a 10x10 pixels sprite. By default,
/// the sprite is positioned/rotated/scaled relatively to its top-left corner, because it is the local point (0, 0).
/// But if we change the origin to be (5, 5), the sprite will be positioned/rotated/scaled around its center instead.
/// And if we set the origin to (10, 10), it will be transformed around its bottom-right corner.
/// 
/// To keep the `TransformHandler` class simple, there's only one origin for all the components. You cannot position
/// the sprite relatively to its top-left corner while rotating it around its center, for example. To do such things, 
/// use `Transform` directly.
///
/// `TransformHandler` can be used through the `Transformable` protocol, which is a requirement for the `Drawable`
/// protocol.
///
///     struct MyEntity: Transformable { 
///         var transformations = TransformHandler()
///     }
///
///     // We can now transform our entity
///     var entity = MyEntity()
///     entity.setPosition(to: Vector2F(x: 10, y: 20))
///     entity.setRotation(to: 45)
///
public class TransformHandler {
    internal var handler: OpaquePointer

    /// Creates a new instance based on the identity transform.
    public init() {
        self.handler = sfTransformable_create()
    }

    /// Copies another `TransformHandler`.
    public init(from handler: TransformHandler) {
        self.handler = sfTransformable_copy(handler.handler)
    }

    deinit {
        sfTransformable_destroy(self.handler)
    }

    /// The inverse of the combined transform of the object.
    public var inverseTransform: Transform {
        sfTransformable_getInverseTransform(self.handler)
    }

    /// The origin of all transformations.
    ///
    /// The origin of an object defines the center point for all transformations (position, scale, rotation).
    /// The coordinates of this point must be relative to the top-left corner of the object, and ignore all
    /// transformations (position, scale, rotation). The default origin of a transformable object is (0, 0).
    public var origin: Vector2F {
        get { sfTransformable_getOrigin(self.handler) }
        set { sfTransformable_setOrigin(self.handler, newValue) }
    }

    /// The current position.
    public var position: Vector2F {
        get { sfTransformable_getPosition(self.handler) }
        set { sfTransformable_setPosition(self.handler, newValue) }
    }

    /// The current rotation.
    public var rotation: Float {
        get { sfTransformable_getRotation(self.handler) }
        set { sfTransformable_setRotation(self.handler, newValue) }
    }

    /// The current scale on the X and Y axis.
    public var scale: Vector2F {
        get { sfTransformable_getScale(self.handler) }
        set { sfTransformable_setScale(self.handler, newValue) }
    }

    /// The combined transform of the object. 
    public var transform: Transform {
        sfTransformable_getTransform(self.handler)
    }

    // MARK: Methods

    /// Rotates the object.
    ///
    /// This function adds to the current rotation of the object.
    /// - parameter angle: The angle of rotation, in degrees.
    public func rotate(by angle: Float) {
        sfTransformable_rotate(self.handler, angle)
    }

    /// Scale the object.
    ///
    /// This function adds to the current scaling.
    /// - parameter factors: The factors of scaling on the X and Y axis.
    public func scale(by factors: Vector2F) {
        sfTransformable_scale(self.handler, factors)
    }

    /// Moves the object by a given object.
    ///
    /// - parameter offset: The offset to apply.
    public func translate(by offset: Vector2F) {
        sfTransformable_move(self.handler, offset)
    }
}