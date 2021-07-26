// Mouse.swift
// Created by Jérémy Goyette
// On 2021/07/24
// For SwiftSFML

import CSFML
import Foundation

/// Gives access to the real-time state of the mouse.
public struct Mouse {

    /// The position of the mouse relative to the desktop.
    static public var position: Vector2I {
        get {
            sfMouse_getPosition(nil)
        } set {
            sfMouse_setPosition(newValue, nil)
        }
    }

    /// Checks if a mouse button is pressed.
    ///
    /// > Tip: Subscript notation is also available.
    static public func isButtonPressed(_ button: Button) -> Bool {
        sfMouse_isButtonPressed(sfMouseButton(rawValue: button.rawValue)) != 0
    }

    static public subscript(button: Button) -> Bool {
        isButtonPressed(button)
    }

    /// Mouse buttons
    public enum Button: UInt32 {
        /// The left mouse button.
        case left
        /// The right mouse button.
        case right
        /// The middle mouse button (wheel).
        case middle
        /// The first extra mouse button.
        case extra1
        /// The second extra mouse button.
        case extra2
    }

    /// Mouse wheels
    public enum Wheel {
        /// The vertical mouse wheel.
        case vertical
        /// The horizontal mouse wheel.
        case horizontal
    }
}