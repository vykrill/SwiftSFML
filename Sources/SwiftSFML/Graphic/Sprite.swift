// Sprite.swift
// Created by Jérémy Goyette
// On 2021/01/07
// For SwiftSFML

import CSFML

public class Sprite {
    internal var sprite: OpaquePointer

    public var texture: Texture?

    /// Creates a sprite with no source texture.
    public init() {
        self.sprite = sfSprite_create()
    }

    /// Creates a new sprite from a pre-existing one.
    ///
    /// - remark: The two sprites share the same texture.
    ///
    /// - parameter sprite: The source sprite.
    public init(from sprite: Sprite) {
        self.sprite = sfSprite_copy(sprite.sprite)
        self.texture = sprite.texture
    }

    public convenience init(from texture: Texture, rect: RectI? = nil) {
        self.init()
        self.texture = texture
        
        if rect != nil {
            self.textureRect = rect!
        }

    }

    public var textureRect: RectI {
        get { sfSprite_getTextureRect(self.sprite) }
        set { sfSprite_setTextureRect(self.sprite, newValue) }
    }

    // Link `sprite` to `Texture`.
    private func setupTexture() {
        sfSprite_setTexture(self.sprite, self.texture?.texture, 0)
    }
}