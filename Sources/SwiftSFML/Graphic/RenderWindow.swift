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

    /// Whether the render window has the input focus.
    ///
    /// At any given time, only one window may have the input
    ///  focus to receive input events such as keystrokes or most mouse events.
    ///
    /// `true` if the window has focus, `false` otherwise. 
    public var hasFocus: Bool { 
        sfRenderWindow_hasFocus(self.window) != 0
    }

    /// Whether the window is opened or not.
    public var isOpen: Bool {
        sfRenderWindow_isOpen(self.window) != 0
    }

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

    // MARK: Initialisation and deinitialisation
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

    // MARK: Methods
    /// Close the render window, but does not destroy the internal data.
    public func close() {
        sfRenderWindow_close(self.window)
    }

    /// Update and display the render window on screen.
    public func display() {
        sfRenderWindow_display(self.window)
    }

}