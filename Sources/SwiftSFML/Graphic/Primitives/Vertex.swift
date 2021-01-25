// Vertex.swift
// Created by Jérémy Goyette
// On 2021/01/09
// For SwiftSFML

import CSFML

/// Define a point with color and texture coordinates.
///
/// A vertex is an improved point.
///
/// It has a position and other extra attributes that will be used for drawing: in SFML, vertices also have a color and a pair of texture coordinates.
///
/// The vertex is the building block of drawing. Everything which is visible on screen is made of vertices. They are grouped as 2D primitives (triangles, quads, ...), and these primitives are grouped to create even more complex 2D entities such as sprites, texts, etc.
///
/// If you use the graphical entities of SFML (sprite, text, shape) you won't have to deal with vertices directly. But if you want to define your own 2D entities, such as tiled maps or particle systems, using vertices will allow you to get maximum performances. For this, use the `Drawable` or the `VertexArray` protocol.
///
/// - note: Although texture coordinates are supposed to be an integer amount of pixels, their type is float because of some buggy graphics drivers that are not able to process integer coordinates correctly.
public typealias Vertex = sfVertex
