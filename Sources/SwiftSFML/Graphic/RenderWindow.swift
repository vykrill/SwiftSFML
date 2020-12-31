// RenderWindow.swift
// Created by Jérémy Goyette
// On 2020/12/31
// For SwiftSFML

import CSFML
import Foundation

/// A window that can serve as a target for 2D rendering.
public class RenderWindow {
    /// The underlying SFML `sf::RenderWindow` instance.
    private var window: OpaquePointer

    /// Creates a new window with a UTF-32 title.
    public init(mode: VideoMode, title: String, 
                style: WindowStyle = .defaultStyle, 
                settings: inout ContextSettings) {
        
        

        self.window = sfRenderWindow_createUnicode(mode, 
                                                   title.utf32, 
                                                   style.rawValue, 
                                                   &settings)
    }

    /// Creates a new window with a UTF-32 title and default window creation settings.
    public init(mode: VideoMode, title: String, style: WindowStyle = .defaultStyle) {
        self.window = sfRenderWindow_createUnicode(mode, title.utf32, style.rawValue, nil)
    }

}