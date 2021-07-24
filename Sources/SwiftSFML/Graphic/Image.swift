// Image.swift
// Created by Jérémy Goyette
// On 2021/01/08
// For SwiftSFML

import CSFML
import Foundation

public class Image {
    /// The internal SFML `sf::Image` instance.
    internal var image: OpaquePointer

    /// The size of the image in pixels.
    public var size: Vector2U {
        sfImage_getSize(self.image)
    }

    /// The width of the image in pixels.
    public var width: UInt32 {
        self.size.x
    }

    /// The height of the image in pixels.
    public var height: UInt32 {
        self.size.y
    }

    /// Creates an image and fills it with a color.
    ///
    /// - parameters:
    ///     - width: Width of the new image.
    ///     - height: Height of the new image.
    ///     - fillColor: The color to fill the image with.
    public init(width: UInt32, height: UInt32, fillColor: Color = .black) {
        self.image = sfImage_createFromColor(width, height, fillColor)
    }

    /// Creates an image from a file on disk.
    /// 
    /// The supported image formats are bmp, png, tga, jpg, gif, psd, hdr and pic. Some format options are not
    /// supported, like progressive jpeg. If this function fails, the image is left unchanged.
    ///
    /// - parameter url: The URL of the file.
    public init?(fromFileURL url: URL?) {
        if url != nil, let image = sfImage_createFromFile(url!.path) {
                self.image = image
            } else {
                return nil
            }
    }

    deinit {
        sfImage_destroy(self.image)
    }

    // MARK: Methods
    
    /// Create a transparency mask from a specified color-key.
    /// 
    /// This function sets the alpha value of every pixel matching the given color to alpha (0 by default),
    /// so that they become transparent.
    ///
    /// - parameters:
    ///     - color: The color to make transparent.
    ///     - alpha: The alpha value to assign to the transparent pixels.
    public func createMask(from color: Color, alpha: UInt8 = 0) {
        sfImage_createMaskFromColor(self.image, color, alpha)
    }

    /// Flip an image horizontally (left <-> right) 
    public func flipHorizontally() {
        sfImage_flipHorizontally(self.image)
    }

    /// Flip an image vertically (top <-> bottom) 
    public func flipVertically() {
        sfImage_flipVertically(self.image)
    }

    /// Save an image to a file on disk.
    ///
    /// The format of the image is automatically deduced from the 
    /// extension. The supported image formats are bmp, png, tga 
    /// and jpg. The destination file is overwritten if it already
    /// exists. This function fails if the
    /// image is empty.
    public func save(to url: URL) -> Bool {
        sfImage_saveToFile(self.image, url.path) != 0
    }

    // MARK: Pixel manipulation

    /// Get the color of a pixel in an image.
    /// 
    /// This function doesn't check the validity of the pixel 
    /// coordinates, using out-of-range values will result in an
    /// undefined behaviour.
    ///
    /// - parameters: 
    ///     - x: The X coordinate of the pixel to get.
    ///     - y: The Y coordinate of the pixel to get.
    ///
    /// - returns: The color of the pixel at (x, y).
    ///
    /// > Warning: This method is deprecated. Use subscript notation
    /// > instead.
    public func getPixelAt(x: UInt32, y: UInt32) -> Color {
        sfImage_getPixel(self.image, x, y)
    }

    /// An interface to access and modify the image's pixel data.
    subscript(x: UInt32, y: UInt32) -> Color {
        get {
            assert(verifyPixelPositionAt(x: x, y: y), "The pixel is out of bounds.")
            return sfImage_getPixel(self.image, x, y)
        } set {
            assert(verifyPixelPositionAt(x: x, y: y), "The pixel is out of bounds.")
            sfImage_setPixel(self.image, x, y, newValue)
        }
    }

    /// Get a read-only pointer to the array of pixels of an image.
    /// 
    /// The returned value points to an array of RGBA pixels made
    /// of 8 bits integers components. The size of the array
    /// is `width.y * height * 4`. 
    ///
    /// - Warning: the returned pointer may become invalid if you
    /// modify the image, so you should never store it for too
    /// long.
    ///
    /// - returns: `nil` if the image is empty; otherwise the array of pixels.
    public func getPixels() -> [UInt8]? {
        guard let pointer = sfImage_getPixelsPtr(self.image) else {
            return nil
        }

        let size = Int(self.size.x * self.size.y * 4)
        var array = [UInt8]()
        for i in 0..<size {
            array.append(pointer[i])
        }

        return array
    }

    /// Verifies if a pixel index is within the bounds of the image.
    private func verifyPixelPositionAt(x: UInt32, y: UInt32) -> Bool {
        return x < self.size.x && y < self.size.y
    }
}