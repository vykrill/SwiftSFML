// CircleShape.swift
// Created by Jérémy Goyette
// On 2021/01/04
// For SwiftSFML

import CSFML

public class CircleShape {
    /// The underlying pointer to a sfCircleShape instance.
    internal var shape = sfCircleShape_create()

    /// Creates a new circle shape with the specified radius.
    /// - parameter radius: The radius of the circle.
    public init(radius: Float) {
        sfCircleShape_setRadius(self.shape, radius)
    }

    /// Creates a new circle shape from a pre-existing shape.
    public init(from shape: CircleShape) {
        self.shape = sfCircleShape_copy(shape.shape)
    }

    deinit {
        sfCircleShape_destroy(self.shape)
    }

    /// The fill color of the shape.
    ///
    /// This color is modulated (multiplied) with the shape's texture if any. It can be used to colorize the shape,
    /// or change its global opacity. You can use `Color.transparent` to make the inside of the shape transparent, and have
    /// the outline alone. By default, the shape's fill color is opaque white.
    public var fillColor: Color {
        get { sfCircleShape_getFillColor(self.shape) }
        set { sfCircleShape_setFillColor(self.shape, newValue) }
    }

    /// the global bounding rectangle of a circle shape.
    /// 
    /// The returned rectangle is in global coordinates, which means that it takes in account the transformations<
    /// (translation, rotation, scale, ...) that are applied to the entity. In other words, it is the bounds of the 
    /// sprite in the global 2D world's coordinate system.
    public var globalBounds: RectF {
        sfCircleShape_getGlobalBounds(self.shape)
    }

    /// Get the local bounding rectangle of a circle shape.
    ///
    /// The returned rectangle is in local coordinates, which means that it ignores the transformations
    /// (translation, rotation, scale, ...) that are applied to the entity. In other words, it is the bounds of the
    /// entity in the entity's coordinate system.
    public var localBounds: RectF {
        sfCircleShape_getLocalBounds(self.shape)
    }

    /// The local origin of a circle shape.
    ///
    /// The origin of an object defines the center point for all transformations (position, scale, rotation). 
    /// The coordinates of this point must be relative to the top-left corner of the object, and ignore all 
    /// transformations (position, scale, rotation). The default origin of a circle Shape object is (0, 0).
    public var origin: Vector2F {
        get { sfCircleShape_getOrigin(self.shape) }
        set { sfCircleShape_setOrigin(self.shape, newValue) }
    }

    /// Set the outline color of a circle shape.
    ///
    /// You can use `Color.transparent` to disable the outline. By default, the shape's outline color is opaque white.
    public var outlineColor: Color {
        get { sfCircleShape_getOutlineColor(self.shape) }
        set { sfCircleShape_setOutlineColor(self.shape, newValue) }
    }

    /// Set the thickness of a circle shape's outline.
    ///
    /// This number cannot be negative. Using zero disables the outline. By default, the outline thickness is 0.
    public var outlineThickness: Float {
        get { sfCircleShape_getOutlineThickness(self.shape) }
        set { sfCircleShape_setOutlineThickness(self.shape, newValue) }
    }

    /// Set the number of points of a circle. 
    public var pointCount: Int {
        get { sfCircleShape_getPointCount(self.shape) }
        set { sfCircleShape_setPointCount(self.shape, newValue) }
    }

    /// The position of the circle shape.
    ///
    /// To apply an offest to the position, use the `move(by:)` method. The default position of a 
    /// circle Shape object is (0, 0).
    public var position: Vector2F {
        get { sfCircleShape_getPosition(self.shape) }
        set { sfCircleShape_setPosition(self.shape, newValue) }
    }

    /// The radius of the circle.
    public var radius: Float {
        get { sfCircleShape_getRadius(self.shape) }
        set { sfCircleShape_setRadius(self.shape, newValue) } 
    }

    /// The orientation of the circle shape.
    ///
    /// use the `rotate(by:)` method to add an angle based on the previous rotation. The default rotation is 0.
    public var rotation: Float {
        get { sfCircleShape_getRotation(self.shape) }
        set { sfCircleShape_setRotation(self.shape, newValue) }
    }

    /// The scale of the circle.
    ///
    /// Use the `scale(by:)` method to add a factor based on the previous scale. The default scale is (1, 1).
    public var scale: Vector2F {
        get { sfCircleShape_getScale(self.shape) }
        set { sfCircleShape_setScale(self.shape, newValue) }
    }

    // MARK: Methods
    /// Move a circle shape by a given offset. 
    ///
    /// This function adds to the current position of the object, unlike `position` which overwrites it.
    /// - parameter offset: The offset to apply.
    public func move(by offset: Vector2F) {
        sfCircleShape_move(self.shape, offset)
    }

    /// Rotate a circle shape.
    /// 
    /// This function adds to the current rotation of the object, unlike `rotation` which overwrites it.
    /// - parameter angle: The angle of rotation in degrees.
    public func rotate(by angle: Float) {
        sfCircleShape_rotate(self.shape, angle)
    }

    /// Scale a circle shape.
    ///
    /// This function multiplies the current scale of the object, unlike `scale` which overwrites it.
    public func scale(by factors: Vector2F) {
        sfCircleShape_scale(self.shape, factors)
    }
}