// Rect.swift
// Created by Jérémy Goyette
// On 2021/01/03
// For SwiftSFML

import CSFML

/// Utility struct for manipulating 2D axis aligned rectangles.
/// 
/// A rectangle is defined by its top-left corner and its size.
/// 
/// It is a very simple struct defined for convenience, so its member variables (left, top, width and height) are
/// public and can be accessed directly, just like the vector structs (`Vector2F` and `Vector3F`).
/// 
/// To keep things simple, `RectF` doesn't define functions to emulate the properties that are not directly members
/// (such as right, bottom, center, etc.), it rather only provides intersection functions.
/// 
/// `RectF` uses the usual rules for its boundaries:
///  - The left and top edges are included in the rectangle's area
///  - The right (left + width) and bottom (top + height) edges are excluded from the rectangle's area
/// 
/// This means that `RectF(0, 0, 1, 1)` and `RectF(1, 1, 1, 1)` don't intersect.
public typealias RectF = sfFloatRect

extension RectF: Equatable {
    /// Check if a point is inside the rectangle's area.
    ///
    /// This check is non-inclusive. If the point lies on the edge of the rectangle, this function will return `false`.
    /// 
    /// - parameters:
    ///     - x: The X coordinate of the point to test.
    ///     - y: The y coordinate of the point to test.
    ///
    /// - returns: `true` if the point is inside the rect, otherwise `false`.
    public func contains(x: Float, y: Float) -> Bool {
        var temp = self
        return sfFloatRect_contains(&temp, x, y) != 0
    }

    /// Check if a point is inside the rectangle's area.
    ///
    /// This check is non-inclusive. If the point lies on the edge of the rectangle, this function will return `false`.
    /// 
    /// - parameter x: The point to test.
    ///
    /// - returns: `true` if the point is inside the rect, otherwise `false`.
    public func contains(point: Vector2F) -> Bool {
        return self.contains(x: point.x, y: point.y)
    }

    /// Check the intersection between two rectangles.
    ///
    /// - parameter rect: The rectangle to test.
    /// - returns: A new `RectF` instance representing the overlap if ther is one, otherwise `nil`.
    public func intersects(rect: RectF) -> RectF? {
        var returnValue = RectF()
        var rect1 = self
        var rect2 = rect

        if sfFloatRect_intersects(&rect1, &rect2, &returnValue) != 0 {
            return returnValue
        } else {
            return nil
        }

    }

    static public func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.left == rhs.left) && (lhs.top == rhs.top) && (lhs.width == rhs.width) && (lhs.height == rhs.height)
    }
}

/// Utility struct for manipulating 2D axis aligned rectangles.
/// 
/// A rectangle is defined by its top-left corner and its size.
/// 
/// It is a very simple struct defined for convenience, so its member variables (left, top, width and height) are
/// public and can be accessed directly, just like the vector structs (`Vector2I` and `Vector3F`).
/// 
/// To keep things simple, `RectI` doesn't define functions to emulate the properties that are not directly members
/// (such as right, bottom, center, etc.), it rather only provides intersection functions.
/// 
/// `RectF` uses the usual rules for its boundaries:
///  - The left and top edges are included in the rectangle's area
///  - The right (left + width) and bottom (top + height) edges are excluded from the rectangle's area
/// 
/// This means that `RectI(0, 0, 1, 1)` and `RectI(1, 1, 1, 1)` don't intersect.
public typealias RectI = sfIntRect

extension RectI: Equatable {
    
    /// Check if a point is inside the rectangle's area.
    ///
    /// This check is non-inclusive. If the point lies on the edge of the rectangle, this function will return `false`.
    /// 
    /// - parameters:
    ///     - x: The X coordinate of the point to test.
    ///     - y: The y coordinate of the point to test.
    ///
    /// - returns: `true` if the point is inside the rect, otherwise `false`.
    public func contains(x: Int, y: Int) -> Bool {
        var temp = self
        return sfIntRect_contains(&temp, Int32(x), Int32(y)) != 0
    }
    
    /// Check if a point is inside the rectangle's area.
    ///
    /// This check is non-inclusive. If the point lies on the edge of the rectangle, this function will return `false`.
    /// 
    /// - parameter x: The point to test.
    ///
    /// - returns: `true` if the point is inside the rect, otherwise `false`.
    public func contains(point: Vector2I) -> Bool {
        return self.contains(x: Int(point.x), y: Int(point.y))
    }

    /// Check the intersection between two rectangles.
    ///
    /// - parameter rect: The rectangle to test.
    /// - returns: A new `RectI` instance representing the overlap if ther is one, otherwise `nil`.
    public func intersects(rect: RectI) -> RectI? {
        var returnValue = RectI()
        var rect1 = self
        var rect2 = rect

        if sfIntRect_intersects(&rect1, &rect2, &returnValue) != 0 {
            return returnValue
        } else {
            return nil
        }

    }
    
    static public func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.left == rhs.left) && (lhs.top == rhs.top) && (lhs.width == rhs.width) && (lhs.height == rhs.height)
    }
}

