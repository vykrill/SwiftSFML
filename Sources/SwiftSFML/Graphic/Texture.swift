// Texture.swift
// Created by Jérémy Goyette
// On 2021/01/06
// For SwiftSFML

import CSFML
import Foundation

public struct Texture {
    internal var texture: OpaquePointer

    public init?(width: UInt, height: UInt) {
        self.texture = sfTexture_create(UInt32(width), UInt32(height))
        if self.texture == nil {
            return nil
        }
    }

    public init?(fromURL url: URL, withArea area: RectI?) {
        if var areaM = area {
            self.texture = sfTexture_createFromFile(url.path, &areaM)
        } else {
            self.texture = sfTexture_createFromFile(url.path, nil)
        }
    }
}