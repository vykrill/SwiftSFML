// Texture.swift
// Created by Jérémy Goyette
// On 2021/01/06
// For SwiftSFML

import CSFML
import Foundation

public class Texture {
    internal var texture: OpaquePointer
    
    /// Creates a new texture of the given dimensions.
    ///
    /// - parameters:
    ///     - width: The width of the new texture.
    ///     - heigth: The height of the new texture.
    ///
    /// - returns: A new `Texture` object, or `nil` if the initialisation fails.
    public init?(width: UInt, height: UInt) {
        
        if let tex = sfTexture_create(UInt32(width), UInt32(height)) {
            self.texture = tex
        } else {
            return nil
        }
    }

    /// Creates a new texture from an image file.
    ///
    /// - parameters:
    ///     - url: The url of the image file.
    ///     - area: The area of the source image to load. (`nil` to load the whole image).
    ///
    /// - returns: A new `Texture` object, or `nil` if it fails.
    public init?(fromURL url: URL, withArea area: RectI?) {
        if var areaM = area {
            if let tex = sfTexture_createFromFile(url.path, &areaM) {
                self.texture = tex
            } else {
                return nil
            }
        } else {
            if let tex = sfTexture_createFromFile(url.path, nil) {
                self.texture = tex
            } else {
                return nil
            }
        }
    }
    
    deinit {
        sfTexture_destroy(self.texture)
    }
}
