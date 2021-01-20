//
//  View.swift
//  SwiftSFML
//
//  Created by Jérémy Goyette on 2021-01-19.
//

import CSFML
import Foundation

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
    public init(from rect: RectF = RectF(left: 0, top: 0, width: 1000, height: 1000)) {
        self.view = sfView_createFromRect(rect)
    }

    /// Copies another view.
    public init(from view: View) {
        self.view = sfView_copy(view.view)
    }

    /// Creates a new 'View' from an existing 'sfView'.
    internal init(from csfmlView: OpaquePointer) {
        self.view = csfmlView
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
    /// - 1 keeps the size unchanged
    /// - > 1 makes the view bigger (objects appear smaller)
    /// - < 1 makes the view smaller (objects appear bigger)
    public func zoom(by factor: Float) {
        sfView_zoom(self.view, factor)
    }
}