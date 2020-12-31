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

    // MARK: Properties
    /// The position of the `RenderWindow` in pixels.
    ///
    /// Modifying the position only work on top level windows.
    public var position: Vector2I {
        get { sfRenderWindow_getPosition(self.window) }
        set { sfRenderWindow_setPosition(self.window, newValue) }
    }

    /// The size of the rendering region of the window.
    public var size: Vector2U {
        get { sfRenderWindow_getSize(self.window) }
        set { sfRenderWindow_setSize(self.window, newValue) }
    }

    /// The creation settings of the window.
    public var settings: ContextSettings { 
        sfRenderWindow_getSettings(self.window)
    }

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

    deinit {
        sfRenderWindow_destroy(self.window)
    }

}