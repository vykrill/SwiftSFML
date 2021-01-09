// PrimitiveType.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

/// Types of primitives that a `VertexArray` can render.
///
/// Points and lines have no area, therefore their thickness will always be 1 pixel, regardless the current transform
/// and view. 
public enum PrimitiveType: UInt32 {
    /// A set of unconnected points. 
    ///
    /// These points have no thickness: They will always occupy a single pixel,
    /// regardless of the current transform and view. 
    case points = 0
    /// A set of unconnected lines.
    ///
    /// These lines have no thickness: They will always be one pixel wide, regardless of the current transform and view. 
    case lines
    /// A set of connected lines. 
    ///
    /// The end vertex of one line is used as the start vertex of the next one. 
    case lineStrip
    /// A set of unconnected triangles. 
    case triangles
    /// A set of connected triangles. 
    /// 
    /// Each triangle shares its two last vertices with the next one. 
    case triangleStrip
    /// A set of triangles connected to a central point. 
    ///
    /// The first vertex is the center, then each new vertex defines a new triangle, using the center and the previous
    /// vertex. 
    case triangleFan
    /// A set of unconnected quads.
    ///
    /// The 4 points of each quad must be defined consistently, either in clockwise or counter-clockwise order. 
    case quads
}