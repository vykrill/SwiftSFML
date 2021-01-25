//
//  View.swift
//  SwiftSFML
//
//  Created by Jérémy Goyette on 2021-01-19.
//

import CSFML
import Foundation

/// 2D camera that defines what region is shown on screen
/// 
/// `View` defines a camera in the 2D scene.
/// 
/// This is a very powerful concept: you can scroll, rotate or zoom the entire scene without altering the way that your
/// drawable objects are drawn.
/// 
/// A view is composed of a source rectangle, which defines what part of the 2D scene is shown, and a target viewport,
/// which defines where the contents of the source rectangle will be displayed on the render target (window or texture).
/// 
/// The viewport allows to map the scene to a custom part of the render target, and can be used for split-screen or for
/// displaying a minimap, for example. If the source rectangle doesn't have the same size as the viewport, its contents
/// will be stretched to fit in.
/// 
/// To apply a view, you have to assign it to the render target. Then, objects drawn in this render target will be
/// affected by the view until you use another view.
public class View {
    /// The underlying sfView instance.
    internal var view: OpaquePointer

    /// The center of the view.
    public var center: Vector2F {
        get { sfView_getCenter(self.view) }
        set { sfView_setCenter(self.view, newValue) }
    }

    /// The orientation of the view.
    ///
    /// The default rotation of a view is 0 degree.
    public var rotation: Float {
        get { sfView_getRotation(self.view) }
        set { sfView_setRotation(self.view, newValue) }
    }

    /// The size of the view.
    public var size: Vector2F {
        get { sfView_getSize(self.view) }
        set { sfView_setSize(self.view, newValue) }
    }

    /// The target viewport of the view.
    ///
    /// The viewport is the rectangle into which the contents of the view are displayed, expressed as a factor
    /// (between 0 and 1) of the size of the render target to which the view is applied. For example, a view which takes
    /// the left side of the target would be defined by a rect of (0, 0, 0.5, 1). By default, a view has a viewport
    /// which covers the entire target.
    public var viewport: RectF {
        get { sfView_getViewport(self.view) }
        set { sfView_setViewport(self.view, newValue) }
    }

    /// Constructs a view from a rectangle
    ///
    /// - parameter rect: The zone to display. Defaults to (0, 0, 1000, 1000).
    public init(rect: RectF = RectF(left: 0, top: 0, width: 1000, height: 1000)) {
        self.view = sfView_createFromRect(rect)
    }

    /// Constructs a view from its center and size.
    ///
    /// - parameters:
    ///     - center: The center of the zone to display.
    ///     - size: The size of the zone to display.
    public convenience init(center: Vector2F, size: Vector2F) {
        let rect = RectF(left: center.x - (size.x / 2), top: center.y - (size.y / 2), width: size.x, height: size.y)
        self.init(rect: rect)
    }

    /// Copies another view.
    /// - parameter view: The view to copy.
    public init(from view: View) {
        self.view = sfView_copy(view.view)
    }

    /// Creates a new 'View' from an existing 'sfView'.
    /// - parameter csfmlView: The source view.
    internal init(_ csfmlView: OpaquePointer) {
        self.view = sfView_copy(csfmlView)
    }

    deinit {
        sfView_destroy(self.view)
    }

    /// Resets the view to the given rectangle.
    ///
    /// - note: This function resets the rotation to 0.
    /// - parameter rect: The rectangle defining the zone to display.
    public func reset(to rect: RectF) {
        sfView_reset(self.view, rect)
    }

    /// Moves a view relatively to its current position.
    ///
    /// - parameter offset: The offset to apply. 
    public func translate(by offset: Vector2F) {
        sfView_move(self.view, offset)
    }

    /// Resize a view rectangle relatively to its current size.
    /// 
    /// Resizing the view simulates a zoom, as the zone displayed on screen grows or shrinks. factor is a multiplier:
    ///
    ///
    /// - parameter factor: The scale factor of the view:
    ///     - 1 keeps the size unchanged
    ///     - > 1 makes the view bigger (objects appear smaller)
    ///     - < 1 makes the view smaller (objects appear bigger)
    public func zoom(by factor: Float) {
        sfView_zoom(self.view, factor)
    }
}
