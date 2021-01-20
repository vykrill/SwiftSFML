// BlendMode.swift
// Created by Jérémy Goyette
// On 2021/01/07
// For SwiftSFML

import CSFML

public struct RenderState {
    /// Defines how pixels of the object are blended with the background. 
    public var blendMode = BlendMode.alphaBlending
    /// Defines how the object is positioned/rotated/scaled.
    public var transform = Transform.identity
    /// Defines what image is mapped to the object 
    public var texture: Texture?
    /// Defines what custom effect is applied to the object.
    // public var shader: Shader?

    /// The CSFML equivalent to this `RenderState`.
    internal var csfmlRenderState: sfRenderStates {
        sfRenderStates(
            blendMode: self.blendMode.csfmlBlendMode,
            transform: self.transform, 
            texture: self.texture?.texture, 
            shader: nil
        )
    }

    /// Construct a default set of render states with a custom blend mode. 
    /// - parameter blendMode: The blend mode to use.
    public init(_ blendMode: BlendMode) {
        self.blendMode = blendMode
    }

    /// Construct a default set of render states with a custom transform. 
    /// - parameter transform: The transform to use.
    public init(_ transform: Transform) {
        self.transform = transform
    }

    /// Construct a default set of render states with a custom texture. 
    /// - parameter texture: The texture to use.
    public init(_ texture: Texture) {
        self.texture = texture
    }

    /*
    /// Construct a default set of render states with a custom shader.
    public init(_ shader: Shader)
    */

    // TODO: Add Shader
    /// Construct a set of render states with all its attributes. 
    /// 
    /// You can set all parameters to their default values.
    ///
    /// - parameters:
    ///     - blendMode: The blend mode to use. Defaults to `BlendMode.alphaBlending`.
    ///     - transform: The transform to use. Defaults to `Transform.identity`.
    ///     - texture: The texture to use. Defaults to `nil`
    ///     - shader: The shader to use. Defaults to `nil` (Not implemented)
    public init(blendMode: BlendMode = .alphaBlending, transform: Transform = .identity, texture: Texture? = nil /* shader: Shader? = nil*/) {
        self.blendMode = blendMode
        self.transform = transform
        self.texture = texture
        // self.shader = shader
    }

    // MARK: Static components
    /// Special instance holding the default render states. 
    static public let `default` = RenderState()
}