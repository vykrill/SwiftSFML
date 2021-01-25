// VideoMode.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

/// Defines a video mode (width, height, bpp).
///
/// A video mode is defined by a width and a height in pixels and a depth (in bit per pixel).
///
/// Video modes are used to setup `RenderWindow` at creation time.
///
/// The main usage of video modes is for fullscreen mode: indeed you must use one of the valid video modes allowed by th OS (which are defined by what the monitor and graphics card support),
/// otherwise your window creation will just fail.
///
/// `VideoMode` provides the static property `fullscreenModes`, which contains the list of all the video modes supported by your system.
///
/// A custom video mode can also be checked directly for fullscreen compatibility with its `isValid` property.
///
/// Additionally, `VideoMode` provides the static property `current`, which contains the current mode used by the desktop. This allows to build windows with the same size or pixel depth as the
/// current resolution.
///
/// # Usage Example
///
///     // Display the list of all the video modes available for fullscreen
///     let modes = VideoMode.fullscreenModes
///     for index in modes.indices {
///         print("mode # \(index): \(modes[index].width) x \(modes[index].height) - \(modes.pitsPerPixel) bpp.")
///     }
///
///     // Create a window with the same pixel depth as the desktop.
///     let bpp = VideoMode.current.bitsPerPixel
///     let window = RenderWindow(mode: VideoMode(width: 1024, height: 768, bitsPerPixel: bpp), title: "SFML Window")
///
public typealias VideoMode = sfVideoMode

public extension VideoMode {
    /// The current video mode of the desktop.
    static var current: VideoMode {
        sfVideoMode_getDesktopMode()
    }
    
    /// All the video modes supported in fullscreen mode.
    ///
    /// When creating a fullscreen window, the videomode is restricted to be compatible with what the graphics driver and monitor support. This property contains the complete list of all video
    /// modes that can be used in fullscreen mode. The array is sorted from best to worst, so that the first element will always give the best mode (higher width, height and bits-per-pixel)
    static var fullscreenModes: [VideoMode] {
        var size = 0
        // We retrieve the pointer to the modes.
        guard let pointer = sfVideoMode_getFullscreenModes(&size) else {
            return []
        }
        
        // We collect each mode.
        var modes = [VideoMode]()
        for index in 0..<size {
            modes.append(pointer[index])
        }
        
        return modes
    }
    
    /// Tells whether or not the video mode is valid.
    ///
    /// The validity of video modes is only relevant when using fullscreen windows; otherwise any video mode can be used with no restriction.
    var isValid: Bool {
        sfVideoMode_isValid(self) != 0
    }
}
