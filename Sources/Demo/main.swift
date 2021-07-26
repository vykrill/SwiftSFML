// Demo.swift
// By: Jérémy Goyette
// For: SwiftSFML
// On: 2021/01/02
// 
// This is a little demo covering many functionalities of SwiftSFML. Its main usage thought is to test the new
// features added to the package in an other context than Units Tests.
//
// It contains a textured background and many little spinning icons, behind a larger one at the middle of the window.
// You can use the left and right arrows on the keyboard to change the backround color and the 's' key to toggle the 
// smooth filter on the background. 

import SwiftSFML
import Foundation

print("Welcome to SwiftSFML!")

/// The default width of the window.
let defaultWidth: UInt32 = 640
/// The default height of the window.
let defaultHeight: UInt32 = 480

/// The adress of the center image.
let imageURL = Bundle.module.url(forResource: "texture", withExtension: "png")
print("Path to the image: \(imageURL?.path ?? "Image not found")")
/// The texture used by `sprite`.
let texture = Texture(fromURL: imageURL!, withArea: nil)
/// If the texture is shown.
var showTexture = true

/// The current background hue.
var currentHue: Double = 0

/// The settings used to create the window.
var settings = ContextSettings()
settings.antialiasingLevel = 8

/// The basic transformation of `sprite`.
let transform = Transform()
    .translated(by: Vector2F(x: Float(defaultWidth / 2), y: Float(defaultHeight / 2)))
    .scaled(by: Vector2F(x: 1.5, y: 1.5))

/// The state that will be used to rotate the sprite.
var state = RenderState(transform)

/// The spinning sprite at the middle of the window.
var sprite = Sprite(from: texture!)
// We set the origin to the middle of the sprite.
sprite.origin = Vector2F(x: sprite.localBounds.width / 2, y: sprite.localBounds.height / 2)

/// The background rectangle
var rect = RectangleShape(rect: RectF(left: 0, top: 0, width: Float(defaultWidth), height: Float(defaultHeight)))
rect.origin = Vector2F(x: defaultWidth / 2, y: defaultHeight / 2)
rect.position = Vector2F(x: defaultWidth / 2, y: defaultHeight / 2)

/// The background texture.
guard let rectTexture = Texture(fromURL: Bundle.module.url(forResource: "vertexTexture", withExtension: "png")!) else {
    fatalError("Impossible to load 'vertexTexture.png'")
}
rectTexture.isSmooth = true
rectTexture.isRepeated = true
let rectState = RenderState(rectTexture)

/// The texture for the tiled background.
let renderTexture = RenderTexture(width: 64, height: 64)
renderTexture.isRepeated = true
/// The state of `sprite` for the background.
var renderStateTexture = RenderState()
renderStateTexture.transform = Transform.identity
    .translated(by: Vector2F(x: 32, y: 32))
    .scaled(by: Vector2F(x: 50 / Float(texture!.size.x), y: 50 / Float(texture!.size.y)))
/// The object responsible for drawing the tiled background.
var tiledRect = RectangleShape(
    rect: RectF(left: 0, top: 0, width: Float(defaultWidth), height: Float(defaultHeight)),
    textureRect: RectF(left: 0, top: 0, width: Float(defaultWidth), height: Float(defaultHeight)),
    color: Color(r: 255, g: 255, b: 255, a: 127))
tiledRect.origin = Vector2F(x: defaultWidth / 2, y: defaultHeight / 2)
tiledRect.position = tiledRect.origin
tiledRect.texture = renderTexture.texture

/// The mouse follower
var follower = CircleShape(radius: 10)
follower.fillColor = .green
follower.outlineColor = .black
follower.outlineThickness = 1
follower.origin = Vector2F(x: 10.0, y: 10.0)

/// The event storage.
var event = Event.unknown
/// The main window.
var window = RenderWindow(
    mode: VideoMode(width: defaultWidth, height: defaultHeight, bitsPerPixel: 32),
    title: "SwiftSFML Demo - \(defaultWidth) x \(defaultHeight)",
    style: .defaultStyle,
    settings: settings
)
// This stabilise the framerate. Since our animation if frame-based, the animation speed would otherwise vary easily.
window.setFramerateLimit(to: 60)

/// The window's icon.
if let icon = Image(fromFileURL: imageURL ?? URL(fileURLWithPath: "")) {
    print("Icon set")
    window.setIcon(to: icon)
}

// Main loop
while window.isOpen {
    // We poll all the event that occureed since the last iteration.
    while window.poll(event: &event) {
        switch event {
        case .closed:
            // We close the window, which will break the main loop.
            window.close()
        case let .resized(width, height):
            // We change the title.
            window.setTitle(to: "SwiftSFML Demo - \(width) x \(height)")

            // We scale the background to fill the window.
            let bounds = rect.getGlobalBounds()
            let factor = Vector2F(x: Float(width) / bounds.width, y: Float(height) / bounds.height)
            rect.scale(by: factor)
            tiledRect.scale(by: factor)
            tiledRect.setTextureRect(to: RectF(left: 0, top: 0, width: Float(width), height: Float(height)))
            
            // We adjust the view.
            window.view = View(
                center: Vector2F(x: defaultWidth / 2, y: defaultHeight / 2),
                size: Vector2F(x: width, y: height)
            )
        case let .keyPressed(data):
            switch data.code {
            case .left:
                // Shift the background color.
                currentHue -= 1
                if currentHue < 0 { currentHue = 359}
            case .right:
                // Shift the background color.
                currentHue += 1
                if currentHue >= 360 { currentHue = 0}
            case .s:
                // We toggle the smoothness of the texture.
                rectTexture.isSmooth.toggle()
            case .up:
                follower.radius += 10
                follower.origin += Vector2F(x: 10, y: 10)
            case .down:
                follower.radius -= 10
                follower.origin -= Vector2F(x: 10, y: 10)
            default:
                break
            }
        default:
            break
        }
    }

    // The follower follows the mouse
    follower.position = window.mapPixelToCoords(window.mousePosition)

    // We adjust the background color.
    rect.setColor(to: Color(h: currentHue, s: 1, v: 1))

    // We spin `sprite`.
    state.transform.rotate(by: 1)
    renderStateTexture.transform.rotate(by: -1)

    // Rendering of the render texture.
    renderTexture.clear(withColor: .transparent)
    renderTexture.draw(sprite, renderState: renderStateTexture)
    renderTexture.update()

    // We clear the content of the window.
    window.clear()
    // We draw inside it.
    window.draw(rect, renderState: rectState)
    window.draw(tiledRect)
    window.draw(sprite, renderState: state)
    window.draw(
        follower, 
        renderState: RenderState(.multiplicativeBlending)
    )
    
    // We update the on-screen content.
    window.update()
}
