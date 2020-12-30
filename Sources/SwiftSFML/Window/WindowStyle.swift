// WindowStyle.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

/// The different options available when creating a window.
public struct WindowStyle: OptionSet {
    /// The bit mask for the option set.
    public let rawValue: UInt32
    
    // public static let none = WindowStyle(rawValue: 0)

    /// Title bar + fixed border.
    public static let titlebar   = WindowStyle(rawValue: 1 << 0)
    /// Title bar + resizable border + maximize button.
    public static let resize     = WindowStyle(rawValue: 1 << 1)
    /// Title bar + close button.
    public static let close      = WindowStyle(rawValue: 1 << 2)
    /// Fullscreen mode.
    ///
    /// This flag and all others are mutually exclusive.
    public static let fullscreen = WindowStyle(rawValue: 1 << 3)

    /// The default window style.
    public static let defaultStyle: WindowStyle = [Self.titlebar, Self.resize, Self.close]

    public init(rawValue: UInt32) { 
        self.rawValue = rawValue & 0b1111
    }

}