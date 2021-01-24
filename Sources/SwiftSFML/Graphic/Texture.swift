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
    public init?(fromURL url: URL, withArea area: RectI? = nil) {
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

    /// Copy an existing texture.
    public init(from texture: Texture) {
        self.texture = sfTexture_copy(texture.texture)
    }

    /// Creates a texture from an `sfTexture`.
    internal init(from csfmlTexture: OpaquePointer) {
        self.texture = csfmlTexture
    }
    
    deinit {
        sfTexture_destroy(self.texture)
    }

    /// The size of the picture in pixels.
    public var size: Vector2U {
        get { sfTexture_getSize(self.texture) }
    }

    /// Enable or disable texture repetition.
    ///
    /// Repeating is involved when using texture coordinates outside the texture rectangle [0, 0, width, height]. In
    /// this case, if repeat mode is enabled, the whole texture will be repeated as many times as needed to reach the 
    /// coordinate (for example, if the X texture coordinate is 3 * width, the texture will be repeated 3 times). If
    ///  repeat mode is disabled, the "extra space" will instead be filled with border pixels. 
    ///
    /// - Warning: On very old graphics cards, white pixels may appear when the texture is repeated. With such cards, 
    ///            repeat mode can be used reliably only if the texture has power-of-two dimensions (such as 256x128).
    ///
    /// Repeating is disabled by default.
    public var isRepeated: Bool {
        get { sfTexture_isRepeated(self.texture) != 0 }
        set { sfTexture_setRepeated(self.texture, newValue == true ? 1 : 0) }
    }

    /// Enable or disable the smooth filter on a texture. 
    public var isSmooth: Bool {
        get { sfTexture_isSmooth(self.texture) != 0 }
        set { sfTexture_setSmooth(self.texture, newValue == true ? 1 : 0) }
    }

    /// Enable or disable conversion from sRGB.
    /// 
    /// When providing texture data from an image file or memory, it can either be stored in a linear color space or an
    /// sRGB color space. Most digital images account for gamma correction already, so they would need to be 
    /// "uncorrected" back to linear color space before being processed by the hardware. The hardware can automatically
    /// convert it from the sRGB color space to a linear color space when it gets sampled. When the rendered image gets
    /// output to the final framebuffer, it gets converted back to sRGB.
    /// 
    /// After enabling or disabling sRGB conversion, make sure to reload the texture data in order for the setting to
    /// take effect.
    /// 
    /// This option is only useful in conjunction with an sRGB capable framebuffer. This can be requested during window
    /// creation.
    public var isSrbg: Bool {
        get { sfTexture_isSrgb(self.texture) != 0 }
        set { sfTexture_setSrgb(self.texture, newValue == true ? 1 : 0) }
    }

    /// Generate a mipmap using the current texture data.
    /// 
    /// Mipmaps are pre-computed chains of optimized textures. Each level of texture in a mipmap is generated by
    /// halving each of the previous level's dimensions. This is done until the final level has the size of 1x1. The
    /// textures generated in this process may make use of more advanced filters which might improve the visual quality
    /// of textures when they are applied to objects much smaller than they are. This is known as minification. Because
    /// fewer texels (texture elements) have to be sampled from when heavily minified, usage of mipmaps can also improve
    /// rendering performance in certain scenarios.
    /// 
    /// Mipmap generation relies on the necessary OpenGL extension being available. If it is unavailable or generation
    /// fails due to another reason, this function will return false. Mipmap data is only valid from the time it is
    /// generated until the next time the base level image is modified, at which point this function will have to be
    /// called again to regenerate it.
    ///
    /// - returns: `true` if the mipmapgeneration was successful, otherwise `false`.
    public func generateMipmaps() -> Bool {
        return sfTexture_generateMipmap(self.texture) != 0
    }

    /// Update a texture from an image. 
    ///
    /// - parameters:
    ///     - image: The image to copy to the texture.
    ///     - offset: The offset in the texture where to copy the source pixels.
    public func update(from image: Image, withOffset offset: Vector2U = Vector2U(x: 0, y: 0)) {
        sfTexture_updateFromImage(self.texture, image.image, offset.x, offset.y)
    }

    /// Update a texture from the content of a `RenderWindow`.
    ///
    /// - parameters:
    ///     - window: The render window to copy to the texture.
    ///     - offset: The offset in the texture where to copy the source pixels.
    public func update(from window: RenderWindow, withOffset offset: Vector2U) {
        sfTexture_updateFromRenderWindow(self.texture, window.window, offset.x, offset.y)
    }

    // MARK: Static members
    /// The maximum texture size allowed. 
    static var maximumSize: UInt {
        UInt(sfTexture_getMaximumSize())
    }

    // MARK: Internal members

    /// Backups the texture's data.
    ///
    /// This method **can only** be called by the `RenderTexture` conatining the texture
    /// when it is destroying itself. This will prevent the texture's data to
    /// be destroyed twice, causing a `double free()`-style error. This method
    /// also allows the possibility to keep a strong reference to 
    /// `RenderTexture.texture` while ditching the `RenderTexture`.
    ///
    /// - parameter parent: The caller of the method.
    internal func backupTexture(caller: RenderTexture) {
        assert(caller.texture === self,
            "Texture.backupTexture can only be called by the owner of the texture.")
        self.texture = sfTexture_copy(self.texture)
    } 
}
