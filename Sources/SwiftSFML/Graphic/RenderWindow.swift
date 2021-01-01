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
    /// Creates a new window.
    ///
    /// - parameters:
    ///     - mode: The video mode to use.
    ///     - title: The title of the window.
    ///     - style: The style of the window (defaults to .defaultStyle).
    ///     - settings: Creation settings (defaults to the default settings).
    public init(mode: VideoMode, title: String, 
                style: WindowStyle = .defaultStyle, 
                settings: ContextSettings = ContextSettings()) {
        
        // We can do this since the settings are not modified in the CSFML function.
        var settingsCopy = settings

        // The creation of the window.
        self.window = sfRenderWindow_createUnicode(mode, title.utf32, style.rawValue, &settingsCopy)
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

    /// Request the current render window to be made the active foreground window.
    ///
    ///At any given time, only one window may have the input focus to receive input events such as keystrokes or
    /// mouse events. If a window requests focus, it only hints to the operating system, that it would like to be
    /// focused. The operating system is free to deny the request.
    public func requestFocus() {
        sfRenderWindow_requestFocus(self.window)
    }

    /// Limit the framerate to a maximum fixed frequency for a render window. 
    ///
    /// - parameter limit: Framerate limit in FPS. Must be at least `1`.
    ///                     Set to `nil` to disable the limit.
    public func setFramerate(limit: UInt32?) {
        assert(limit ?? 1 > 0, "The framerate limit must be set to at least 1 (use nil to disable).")
        sfRenderWindow_setFramerateLimit(self.window, limit ?? 0)
    }

    /// Change the title of the window.
    ///
    /// - parameter title: The new title.
    public func setTitle(_ title: String) {
        sfRenderWindow_setUnicodeTitle(self.window, title.utf32)
    }

    /// Enable / disable vertical synchronization on a render window. 
    ///
    /// - parameter enabled: `true` to enable V-Sync, `false` to disable it.
    public func setVerticalSync(enabled: Bool) {
        sfRenderWindow_setVerticalSyncEnabled(self.window, enabled == true ? 1 : 0)
    }

    /// Show or hide a render window. 
    ///
    /// - parameter visibility: `true` to show the window, `false` to hide it.
    public func setVisible(_ visibility: Bool) {
        sfRenderWindow_setVisible(self.window, visibility == true ? 1 : 0)
    }

}