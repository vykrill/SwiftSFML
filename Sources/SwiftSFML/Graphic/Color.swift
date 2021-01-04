// Color.swift
// Created by Jérémy Goyette
// On 2021/01/03
// For SwiftSFML

import CSFML
import Foundation

/// Utility structure for manipulating RGBA colors.
///
/// A `Color` is composed of 4 components:
/// - Red
/// - Green
/// - Blue
/// - Alpha (opacity)
///
/// Each component is a public member, an unsigned integer in the range [0, 255]. Thus, colors can be constructed
/// and manipulated very easily:
///
///     var color = Color(r: 255, g: 0, b: 0) // Red.
///     color.r = 0                           // Make it black.
///     color.b = 128                         // Make it dark blue.
/// 
/// The fourth component of colors, named "alpha", represents the opacity of the color. A color with an alpha value of 
/// 255 will be fully opaque, while an alpha value of 0 will make a color fully transparent, whatever the value of the
/// other components is.
///
/// The most common colors are already defined as static variables: 
///
///     Color.black
///     Color.white
///     Color.red
///     Color.green
///     Color.blue
///     Color.yellow
///     Color.magenta
///     Color.cyan
///     Color.transparent
///
/// Colors can also be added and modulated (multiplied) using the operators `+` and `*`. 
public typealias Color = sfColor

extension Color {
    /// Creates a new opaque color.
    public init(r: UInt8, g: UInt8, b: UInt8) {
        self = sfColor_fromRGB(r, g, b)
    }

    /// Creates a new color from an integer value.
    public init(from integer: UInt32) {
        self = sfColor_fromInteger(integer)
    }

    /// Creates a new color from HSV value.
    ///
    /// The formulas are taken from https://www.rapidtables.com/convert/color/hsv-to-rgb.html.
    ///
    /// - parameters:
    ///     - h: Hue [0, 360[
    ///     - s: Saturation [0, 1]
    ///     - v: Value [0, 1]
    ///     - a: Alpha [0, 255]
    public init(h: Double, s: Double, v: Double, a: UInt8 = 255) {

        assert(h >= 0 && h < 360, "Hue value must be in the range [0, 360[.")
        assert(s >= 0 && s <= 1, "Saturation must be in the range [0, 1].")
        assert(v >= 0 && v <= 1, "Value must be in the range [0, 1].")

        self.init()

        let c = v * s
        let x = c * (1 - abs((h / 60).truncatingRemainder(dividingBy: 2) - 1))
        let m = v - c
        var tuple: (Double, Double, Double)
        switch h {
        case h where 0 <= h && h < 60:
            tuple.0 = c; tuple.1 = x; tuple.2 = 0
        case h where 60 <= h && h < 120:
            tuple.0 = x; tuple.1 = c; tuple.2 = 0
        case h where 120 <= h && h < 180:
            tuple.0 = 0; tuple.1 = c; tuple.2 = x
        case h where 180 <= h && h < 240:
            tuple.0 = 0; tuple.1 = x; tuple.2 = c
        case h where 240 <= h && h < 300:
            tuple.0 = x; tuple.1 = 0; tuple.2 = c
        case h where 300 <= h && h < 360:
            tuple.0 = c; tuple.1 = 0; tuple.2 = x
        default:
            fatalError()
        }

        self.r = UInt8((tuple.0 + m) * 255)
        self.g = UInt8((tuple.1 + m) * 255)
        self.b = UInt8((tuple.2 + m) * 255)
        self.a = a
    }

    /// The integer version of the color.
    public var integer: UInt32 { sfColor_toInteger(self) }

    /// Black predefined color.    
    static public let black: Color   = sfBlack    
    /// White predefined color.
    static public let white: Color   = sfWhite
    /// Red predefined color.
    static public let red: Color     = sfRed
    /// Green predefined color.
    static public let green: Color   = sfGreen
    /// Blue predefined color.
    static public let blue: Color    = sfBlue
    /// Yellow predefined color.
    static public let yellow: Color  = sfYellow
    /// Magenta predefined color.
    static public let magenta: Color = sfMagenta
    /// Cyan predefined color.
    static public let cyan: Color    = sfCyan
    /// Transparent predefined color.
    static public let transparent: Color = sfTransparent
}

// MARK: Color Algebra
extension Color: Equatable {
    static public func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.integer == rhs.integer
    }

    /// Computes the modulation of two colors.
    ///
    /// This operator returns the component-wise multiplication (also called "modulation") of two colors. Components
    /// are then divided by 255 so that the result is still in the range [0, 255].
    /// 
    /// - parameters:
    ///     - lhs: Left operand.
    ///     - rhs: Right operand.
    /// - returns: The result of `lhs * rhs`.
    static public func * (lhs: Self, rhs: Self) -> Self {
        return sfColor_modulate(lhs, rhs)
    } 

    /// Computes the modulation of two operands and assign the result to the left operand.
    ///
    /// This operator returns the component-wise multiplication (also called "modulation") of two colors, and assigns
    /// the result to the left operand. Components are then divided by 255 so that the result is still in the range 
    /// [0, 255].
    ///
    /// - parameters:
    ///     - lhs: Left operand.
    ///     - rhs: Right operand.
    /// - returns: Reference to `lhs`
    static public func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    /// This operator returns the component-wise sum of two colors. 
    /// 
    /// Components that exceed 255 are clamped to 255.
    ///
    /// - parameters:
    ///     - lhs: Left operand.
    ///     - rhs: Right operand.
    /// - returns: The result of `lhs + rhs`.
    static public func + (lhs: Self, rhs: Self) -> Self {
        return sfColor_add(lhs, rhs)
    }

    /// This operator computes the component-wise sum of two colors, and assigns the result to the left operand. 
    /// 
    /// Components that exceed 255 are clamped to 255.
    /// 
    /// - parameters:
    ///     - lhs: Left operand.
    ///     - rhs: Right operand.
    /// - returns: Reference to left.
    static public func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    /// This operator returns the component-wise subtraction of two colors. 
    /// 
    /// Components below 0 are clamped to 0.
    ///
    /// - parameters:
    ///     - lhs: Left operand.
    ///     - rhs: Right operand.
    /// - returns: The result of `lhs - rhs`.
    static public func - (lhs: Self, rhs: Self) -> Color {
        return sfColor_subtract(lhs, rhs)
    }

    /// This operator computes the component-wise sum of two colors, and assigns the result to the left operand. 
    /// 
    /// Components below 0 are clamped to 0.
    /// 
    /// - parameters:
    ///     - lhs: Left operand.
    ///     - rhs: Right operand.
    /// - returns: Reference to left.
    static public func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}