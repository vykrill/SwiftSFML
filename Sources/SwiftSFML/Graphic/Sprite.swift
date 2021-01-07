// Sprite.swift
// Created by Jérémy Goyette
// On 2021/01/07
// For SwiftSFML

import CSFML

/// Drawable representation of a texture, with its own transformations, color, etc. 
/// 
/// `Sprite` is a drawable class that allows to easily display a texture (or a part of it) on a render target.
/// 
/// `Sprite` works in combination with the `Texture` class, which loads and provides the pixel data of a given texture.
/// 
/// The separation of `Sprite` and `Texture` allows more flexibility and better performances: indeed a `Texture` is a
/// heavy resource, and any operation on it is slow (often too slow for real-time applications). On the other side, a
/// `Sprite` is a lightweight object which can use the pixel data of a `Texture` and draw it with its own
/// transformation/color/blending attributes.
/// 
/// It is important to note that the `Sprite` instance doesn't copy the texture that it uses, it only keeps a strong
/// reference to it. Thus, a `Texture` should not be destroyed while it is used by a `Sprite`.
public class Sprite {
    internal var sprite: OpaquePointer

    public var texture: Texture? {
        didSet { self.setupTexture() }
    }

    // Computed properties
    
    /// The global color of the sprite.
    ///
    /// This color is modulated (multiplied) with the sprite's texture. It can be used to colorize the sprite, or
    /// change its global opacity. By default, the sprite's color is opaque white.
    public var color: Color {
        get { sfSprite_getColor(self.sprite) }
        set { sfSprite_setColor(self.sprite, newValue) }
    }

    /// The local origin of the sprite.
    ///
    /// The origin of an object defines the center point for all transformations (position, scale, rotation). The
    /// coordinates of this point must be relative to the top-left corner of the object, and ignore all transformations
    /// (position, scale, rotation). The default origin of a sprite Sprite object is (0, 0).
    public var origin: Vector2F {
        get { sfSprite_getOrigin(self.sprite) }
        set { sfSprite_setOrigin(self.sprite, newValue) }
    }

    /// The position of the sprite.
    ///
    /// This member completely overwrites the previous position. See the `move(by:)` function to apply an offset based
    /// on the previous position instead. The default position of a `Sprite` object is (0, 0).
    public var position: Vector2F {
        get { sfSprite_getPosition(self.sprite) }
        set { sfSprite_setPosition(self.sprite, newValue) }
    }

    /// The orientation of the sprite in degrees.
    ///
    /// This member completely overwrites the previous rotation. See the `rotate(by:)` method to add an angle based
    /// on the previous rotation instead. The default rotation of a `Sprite` object is 0.
    public var rotation: Float {
        get { sfSprite_getRotation(self.sprite) }
        set { sfSprite_setRotation(self.sprite, newValue) }
    }

    /// The scale factor of the sprite.
    ///
    /// This member completely overwrites the previous scale. See the `scale(by:)` method to add a factor based on the
    /// previous scale instead. The default scale of a `Sprite` object is (1, 1).
    public var scale: Vector2F {
        get { sfSprite_getScale(self.sprite) }
        set { sfSprite_setScale(self.sprite, newValue) }
    }

    /// The sub-rectangle of the texture that a sprite will display.
    /// 
    /// The texture rect is useful when you don't want to display the whole texture, but rather a part of it. By
    /// default, the texture rect covers the entire texture.
    public var textureRect: RectI {
        get { sfSprite_getTextureRect(self.sprite) }
        set { sfSprite_setTextureRect(self.sprite, newValue) }
    }

    // MARK: Read-only properties
    /// The global bounding rectangle of a sprite.
    ///
    /// This rectangle is in global coordinates, which means that it takes in account the transformations
    /// (translation, rotation, scale, ...) that are applied to the entity. In other words, this member is the bounds
    /// of the sprite in the global 2D world's coordinate system.
    public var globalBounds: RectF {
        sfSprite_getGlobalBounds(self.sprite)
    }

    /// the inverse of the combined transform of a sprite.
    public var inverseTransform: Transform {
        sfSprite_getInverseTransform(self.sprite)
    }

    /// The local bounding rectangle of a sprite.
    ///
    /// This rectangle is in local coordinates, which means that it ignores the transformations (translation, rotation,
    /// scale, ...) that are applied to the entity. In other words, this memeber is the bounds of the entity in the
    /// entity's coordinate system.
    public var localBounds: RectF {
        sfSprite_getLocalBounds(self.sprite)
    }

    /// Combined transform of a sprite. 
    public var transform: Transform {
        sfSprite_getTransform(self.sprite)
    }

    // MARK: Initialisation and deinitialisation

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

    /// Creates a sprite from a texture.
    ///
    /// - parameters:
    ///     - texture: The texture to use.
    ///     - textureRect: The sub-rectangle of the texture to assign to the sprite.
    public convenience init(from texture: Texture, textureRect: RectI? = nil) {
        self.init()
        self.texture = texture
        self.setupTexture()
        
        if textureRect != nil {
            self.textureRect = textureRect!
        }

    }

    deinit {
        sfSprite_destroy(self.sprite)
    }

    // MARK: Methods

    /// Move a sprite by a given offset.
    /// 
    /// This function adds to the current position of the object, unlike the `position` property which overwrites it.    
    public func move(by offset: Vector2F) {
        sfSprite_move(self.sprite, offset)
    }

    /// Resets `textureRect` to be the size of the texture.
    ///
    /// This method does nothing if `texture` is set to `nil.`
    public func resetTextureRect() {
        guard self.texture != nil else {
            return
        }

        self.textureRect = RectI(
            left: 0, 
            top: 0, 
            width: Int32(self.texture!.size.x), 
            height: Int32(self.texture!.size.y)
        )
    }

    /// Rotate a sprite.
    /// 
    /// This function adds to the current rotation of the object, unlike the `rotation` property which overwrites it.
    public func rotate(by angle: Float) {
        sfSprite_rotate(self.sprite, angle)
    }

    /// Scale the sprite.
    /// 
    /// This function multiplies the current scale of the object, unlike the `scale` property which overwrites it.
    public func scale(by factors: Vector2F) {
        sfSprite_scale(self.sprite, factors)
    }

    // MARK: Private members.

    /// Link `sprite` to `texture`.
    private func setupTexture() {
        sfSprite_setTexture(self.sprite, self.texture?.texture, 0)
    }
}