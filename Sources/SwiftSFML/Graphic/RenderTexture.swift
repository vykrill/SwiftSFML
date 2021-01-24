// RenderTexture.swift
// Created by Jérémy Goyette
// On 2021/01/20
// For SwiftSFML

import CSFML

public class RenderTexture {
    /// The underlying `sfRenderTexture`.
    internal var target: OpaquePointer
    /// The target texture.
    public var texture: Texture 

    /// Creates a new render texture of the given dimensions.
    public init(width: UInt32, height: UInt32) {
        self.target = sfRenderTexture_create(width, height, 0)
        self.texture = Texture(from: sfRenderTexture_getTexture(self.target))
    }

    deinit {
        print("Destroying render texture...")
        // We backup the final texture data, so we do not cause a `double free` error.
        self.texture.backupTexture(caller: self)
        sfRenderTexture_destroy(self.target)
    }

    // MARK: Texture properties

    /// Enables or disables texture repetition.
    public var isRepeated: Bool {
        get { sfRenderTexture_isRepeated(self.target) != 0 }
        set { sfRenderTexture_setRepeated(self.target, newValue == true ? 1 : 0) }
    }

    /// Enables or disables the smooth filter on a render texture.
    public var isSmooth: Bool {
        get { sfRenderTexture_isSmooth(self.target) != 0 }
        set { sfRenderTexture_setSmooth(self.target, newValue == true ? 1 : 0) }
    }

    /// The size of the rendering region of the render-texture.
    public var size: Vector2U {
        sfRenderTexture_getSize(self.target)
    }

    /// Generate a mipmap using the current texture data.
    ///
    /// This function is similar to `Texture.generateMipmap()` and operates on the texture used as the target for drawing.
    /// Be aware that any draw operation may modify the base level image data. For this reason, calling this function only
    /// makes sense after all drawing is completed and display has been called. Not calling display after subsequent
    /// drawing will lead to undefined behavior if a mipmap had been previously generated.
    ///
    /// - returns: `true` if the mipmap generation was succesful, `false` if the operation is unsuccessful.
    public func generateMipmap() -> Bool {
        sfRenderTexture_generateMipmap(self.target) != 0
    }

    // MARK: Views
    /// The current active view of the render texture.
    ///
    /// Note that a copy of the view is stored in the render texture is stored
    public var view: View {
        get { View(sfRenderTexture_getView(self.target)) }
        set { 
            // let view = sfView_copy(newValue.view)
            sfRenderTexture_setView(self.target, /* view */ newValue.view) 
            // sfView_destroy(view)
        }
    }

    /// The default view of the texture.
    public var defaultView: View {
        get { View(sfRenderTexture_getDefaultView(self.target)) }
    }

    /// Get the viewport of a view applied to this target. 
    ///
    /// - parameter view: The target view.
    /// - returns: The viewport rectangle, expressed in pixels in the current target.
    public func getViewport(of view: View) -> RectI {
        sfRenderTexture_getViewport(self.target, view.view)
    }

    /// Converts a point from world coordinate to texture coordinates.
    ///
    /// This function finds the pixel of the render-texture that matches the
    /// given 2D point. In other words, it goes through the same process as
    /// the graphic card, to compute the final position of a rendered point.
    ///
    /// Initially, both coordinate systems (world units and target units)
    /// match perfectly. But if you define a custom view or resize your
    /// render-texture, this assertion is not true anymore, ie. a point
    /// located at (150, 75) in your 2D world may map to the pixel (10, 50)
    /// of your render-texture - if the view is translated by (140, 25).
    ///
    /// - parameters:
    ///     - point: The point to convert
    ///     - view: The view to use for converting the point. Leave it to `nil`
    ///             to use the current view of the render-texture.
    public func mapCoordsToPixel(_ point: Vector2F, view: View? = nil) -> Vector2I {
        let otherView = view ?? self.view
        return sfRenderTexture_mapCoordsToPixel(self.target, point, otherView.view)
    }

    /// Converts a point from texture coordinates to world coordinates.
    ///
    /// This function finds the 2D position that matches the render-texture.
    /// In other words, it does the inverse of what the graphics card does, to
    /// find the initial position of a rendered pixel.
    ///
    /// Initially, both coordinate systems (world units and target pixels)
    /// matches perfectly. But if you define a custom view or resize your
    /// render-texture, this assertion is not true anymore, ie. a point 
    /// located at (10, 50) in your render-texture may map to the point
    /// (150, 75) in your 2D world - if the view is translated by (140, 25)
    ///
    /// - parameters:
    ///     - pixel: The pixel to convert.
    ///     - view: The view to use for converting the point. Leave it to 
    ///             `nil` to use the current view of the render-texture.
    public func mapPixelToCoords(_ pixel: Vector2I, view: View? = nil) -> Vector2F {
        let otherView = view ?? self.view
        return sfRenderTexture_mapPixelToCoords(self.target, pixel, otherView.view)
    }

    // MARK: Drawing

    /// Clear the render-texture with a color.
    ///
    /// - parameter color: The color to fill the texture with.
    public func clear(withColor color: Color = .black) {
        sfRenderTexture_clear(self.target, color)
    }

    /// Draws a `CircleShape` in the texture.
    ///
    /// - parameters:
    ///     - sprite: The shape to draw.
    ///     - renderState: The render state to use for drawing.
    public func draw(_ other: CircleShape, renderState: RenderState = .default) {
        var state = renderState.csfmlRenderState
        sfRenderTexture_drawCircleShape(self.target, other.shape, &state)
    }

    /// Draws a `Sprite` on the texture.
    ///
    /// - parameters: 
    ///     - other: The sprite to draw.
    ///     - renderState: The render state to use for drawing.
    public func draw(_ other: Sprite, renderState: RenderState = .default) {
        var state = renderState.csfmlRenderState
        sfRenderTexture_drawSprite(self.target, other.sprite, &state)
    }

    /// Draws a `VertexArray` on the texture.
    ///
    /// - parameters: 
    ///     - other: The vertex array to draw.
    ///     - renderState: The render state to use for drawing.
    public func draw(_ other: VertexArray, renderState: RenderState = .default) {
        var state = renderState.csfmlRenderState
        sfRenderTexture_drawPrimitives(
            self.target,
            other.vertices,
            other.vertices.count,
            sfPrimitiveType(rawValue: other.type.rawValue),
            &state
        )
    }

    /// Draws a drawable object in the texture.
    ///
    /// - parameters:
    ///     - other: The `Drawable` object to draw.
    ///     - renderState: Various parameters used for rendering.
    ///                    Note that `renderState.texture` will be used if it is not set to `nil`. Furthermore, `other.transform` will be combined with `renderState.transform`.
    public func draw(_ other: Drawable, renderState: RenderState = .default) {
        var state = renderState
        state.transform = other.transform.combined(with: renderState.transform)
        if state.texture == nil {
            state.texture = other.texture
        }
        self.draw(other as VertexArray, renderState: state)
    }
    
    /// Updates the content of the render texture.
    public func update() {
        sfRenderTexture_display(self.target)
    }
}
