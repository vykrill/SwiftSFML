// WindowStyle.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

public struct WindowStyle: OptionSet {
    public let rawValue: UInt32
    
    // public static let none = WindowStyle(rawValue: 0)

    /// 
    public static let titlebar   = WindowStyle(rawValue: 1 << 0)
    public static let resize     = WindowStyle(rawValue: 1 << 1)
    public static let close      = WindowStyle(rawValue: 1 << 2)
    public static let fullscreen = WindowStyle(rawValue: 1 << 3)

    public static let defaultStyle = [Self.titlebar, Self.resize, Self.close]

    public init(rawValue: UInt32) { 
        self.rawValue = rawValue & 0b1111
    }

}