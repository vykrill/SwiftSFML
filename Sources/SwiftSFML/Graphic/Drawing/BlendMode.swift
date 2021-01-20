// BlendMode.swift
// Created by Jérémy Goyette
// On 2021/01/07
// For SwiftSFML

import CSFML

/// Blending mode for drawing.
///
/// A blend mode determines how the colors of an object you draw are mixed with the colors that are already in the
/// buffer.
///
/// The class is composed of 6 components, each of which has its own public member variable: 
/// - Color Source Factor (`colorSrcFactor`)
/// - Color Destination Factor (`colorDstFactor`) 
/// - Color Blend Equation (`colorEquation`) 
/// - Alpha Source Factor (`alphaSrcFactor`) 
/// - Alpha Destination Factor (`alphaDstFactor`) 
/// - Alpha Blend Equation (`alphaEquation`)
///
/// The source factor specifies how the pixel you are drawing contributes to the final color. The destination factor
/// specifies how the pixel already drawn in the buffer contributes to the final color.
/// 
/// The color channels RGB (red, green, blue; simply referred to as color) and A (alpha; the transparency) can be
/// treated separately. This separation can be useful for specific blend modes, but most often you won't need it and
/// will simply treat the color as a single unit.
/// 
/// The blend factors and equations correspond to their OpenGL equivalents. In general, the color of the resulting
/// pixel is calculated according to the following formula (`src` is the color of the source pixel, `dst` the color 
/// of the destination pixel, the other variables correspond to the public members, with the equations being + or - 
/// operators):
///
///     dst.rgb = colorSrcFactor * src.rgb (colorEquation) colorDstFactor * dst.rgb
///     dst.a   = alphaSrcFactor * src.a   (alphaEquation) alphaDstFactor * dst.a
///     
///  All factors and colors are represented as floating point numbers between 0 and 1. Where necessary, the result is clamped to fit in that range.
///
/// The most common blending modes are defined as static constants:
/// - `alphaBlending`
/// - `additiveBlending`
/// - `multiplicativeBlending`
/// - `noBlending`
///
/// You can use a blend mode each time you draw something in a `RenderWindow` through the `RenderState` argument.
public struct BlendMode: Equatable {

    /// Source blending factor for the color channels. 
    public var colorSrcFactor: Factor
    /// Destination blending factor for the color channels. 
    public var colorDstFactor: Factor
    /// Blending equation for the color channels. 
    public var colorEquation: Equation

    /// Source blending factor for the alpha channel. 
    public var alphaSrcFactor: Factor
    /// Destination blending factor for the alpha channel. 
    public var alphaDstFactor: Factor
    /// Blending equation for the alpha channel. 
    public var alphaEquation: Equation

    /// The `sfBlendMode` corresponding to the current `BlendMode`.
    internal var csfmlBlendMode: sfBlendMode {
        sfBlendMode(
            colorSrcFactor: sfBlendFactor(rawValue: self.colorSrcFactor.rawValue), 
            colorDstFactor: sfBlendFactor(rawValue: self.colorDstFactor.rawValue), 
            colorEquation: sfBlendEquation(rawValue: self.colorEquation.rawValue), 
            alphaSrcFactor: sfBlendFactor(rawValue: self.alphaSrcFactor.rawValue), 
            alphaDstFactor: sfBlendFactor(rawValue: self.alphaDstFactor.rawValue), 
            alphaEquation: sfBlendEquation(rawValue: self.alphaEquation.rawValue)
        )
    }

    /// Constructs a blending mode that does alpha blending.
    public init() {
        self = BlendMode(csfmlBlendMode: sfBlendMode())
    }

    /// Construct the blend mode given the factors and equation.
    ///
    /// This constructor uses the same factors and equation for both color and alpha components.
    ///
    /// - parameters: 
    ///     - sourceFactor: Specifies how to compute the source factor for the color and alpha channels. 
    ///     - destinationFactor: Specifies how to compute the destination factor for the color and alpha channels.
    ///     - blendEquation: Specifies how to combine the source and destination colors and alpha. Defaults to
    ///                      `BlendMode.Equation.add`. 
    public init(sourceFactor: Factor, destinationFactor: Factor, blendEquation: Equation = .add) {
        self = .init(
            colorSourceFactor: sourceFactor, 
            colorDestinationFactor: destinationFactor, 
            colorEquation: blendEquation, 
            
            alphaSourceFactor: sourceFactor, 
            alphaDestinationFactor: destinationFactor, 
            alphaEquation: blendEquation
        )
    }

    // MARK: Static constants
    public static let alphaBlending = BlendMode(csfmlBlendMode: sfBlendAlpha)
    public static let additiveBlending = BlendMode(csfmlBlendMode: sfBlendAdd)
    public static let multiplicativeBlending = BlendMode(csfmlBlendMode: sfBlendMultiply)
    public static let noBlending = BlendMode(csfmlBlendMode: sfBlendNone)

    /// Construct the blend mode given the factors and equation. 
    ///
    /// - parameters:
    ///     - colorSourceFactor: Specifies how to compute the source factor for the color channels. 
    ///     - colorDestinationFactor: Specifies how to compute the destination factor for the color channels. 
    ///     - colorEquation: Specifies how to combine the source and destination colors. 
    ///     - alphaSourceFactor: Specifies how to compute the source factor. 
    ///     - alphaDestinationFactor: Specifies how to compute the destination factor. 
    ///     - alphaEquation: Specifies how to combine the source and destination alphas. 
    public init(colorSourceFactor: Factor, colorDestinationFactor: Factor, colorEquation: Equation,
                alphaSourceFactor: Factor, alphaDestinationFactor: Factor, alphaEquation: Equation) {
                    self.colorSrcFactor = colorSourceFactor
                    self.alphaSrcFactor = alphaSourceFactor

                    self.colorDstFactor = colorDestinationFactor
                    self.alphaDstFactor = alphaDestinationFactor

                    self.colorEquation = colorEquation
                    self.alphaEquation = alphaEquation
                }

    /// Creates a new instance based on a `sfBlendMode` instance.
    private init(csfmlBlendMode mode: sfBlendMode) {
        self.colorSrcFactor = Factor(rawValue: mode.colorSrcFactor.rawValue)!
        self.colorDstFactor = Factor(rawValue: mode.colorDstFactor.rawValue)!
        self.colorEquation = Equation(rawValue: mode.colorEquation.rawValue)!

        self.alphaSrcFactor = Factor(rawValue: mode.alphaSrcFactor.rawValue)!
        self.alphaDstFactor = Factor(rawValue: mode.alphaDstFactor.rawValue)!
        self.alphaEquation = Equation(rawValue: mode.alphaEquation.rawValue)!
    }

    /// Enumeration of the blending factors. 
    ///
    /// The factors are mapped directly to their OpenGL equivalents.
    public enum Factor: UInt32 {
        /// (0, 0, 0, 0) 
        case zero        
        /// (1, 1, 1, 1)     
        case one        
        /// (src.r, src.g, src.b, src.a)       
        case srcColor         
        /// (1, 1, 1, 1) - (src.r, src.g, src.b, src.a) 
        case oneMinusSrcColor 
        /// (dst.r, dst.g, dst.b, dst.a) 
        case dstColor         
        /// (1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a) 
        case oneMinusDstColor 
        /// (src.a, src.a, src.a, src.a) 
        case srcAlpha         
        /// (1, 1, 1, 1) - (src.a, src.a, src.a, src.a) 
        case oneMinusSrcAlpha 
        /// (dst.a, dst.a, dst.a, dst.a) 
        case dstAlpha         
        /// (1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a) 
        case oneMinusDstAlpha 
    }

    /// Enumeration of the blending equations. 
    ///
    /// The factors are mapped directly to their OpenGL equivalents.
    public enum Equation: UInt32 {
        /// Pixel = Src * SrcFactor + Dst * DstFactor. 
        case add
        /// Pixel = Src * SrcFactor - Dst * DstFactor. 
        case substract
        /// Pixel = Dst * DstFactor - Src * SrcFactor. 
        case inverseSubstract
    }
    
}