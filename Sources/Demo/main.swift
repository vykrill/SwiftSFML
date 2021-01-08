import SwiftSFML
import Foundation

print("Hello")

/// The stating width of the window.
let defaultWidth = 640
/// The starting height of the window.
let defaultHeight = 480

/// The radius of the circle.
let radius: Float = 200.0
/// The minimum dimension of the window (not cuurrently used).
let minSize = UInt32(2 * radius)

/// The adress of the image
let imageURL = Bundle.module.url(forResource: "texture", withExtension: "png")
print("Path to the image: \(imageURL?.path ?? "Image not found")")
/// The texture used by the circle shape.
let texture = Texture(fromURL: imageURL!, withArea: nil)
/// If the texture is shown.
var showTexture = true

/// The current background hue.
var currentHue: Double = 0

/// The settings used to create the window.
var settings = ContextSettings()
settings.antialiasingLevel = 8

/// A circle shape
var circle = CircleShape(radius: radius)
// The circle will appear at the center of the window.
circle.origin = Vector2F(x: radius, y: radius)
circle.position = Vector2F(x: Float(defaultWidth) / 2, y: Float(defaultHeight) / 2)
// Appearance of the circle.
circle.outlineColor = .black
circle.outlineThickness = 10.0
circle.fillColor = .white
circle.pointCount = 80
// Texture of the circle
circle.texture = texture
circle.textureRect = RectI(left: 0, top: 0, width: 128, height: 128)

/// Transform of sprite 2
var transform = Transform()
print(transform)
transform.rotate(by: 45, withCenter: Vector2F(x: 64, y: 64))
transform.scale(by: Vector2F(x: 0.5, y: 0.5))

let state = RenderState(transform)

// Sprite
var sprite = Sprite(from: texture!, textureRect: RectI(left: 32, top: 32, width: 128, height: 128))

var sprite2 = Sprite(from: sprite)
//sprite2.scale(by: Vector2F(x: 0.5, y: 0.5))
sprite2.position = Vector2F(
    x: Float(defaultWidth) - sprite2.globalBounds.width,
    y: Float(defaultHeight) - sprite2.globalBounds.height
)
sprite2.rotate(by: -30)
print(sprite2.origin)
sprite2.color = .blue

// Here, we create a new, isolate texture for `sprite`.
// We can test its idependance by maximising the window and pressing the `s` key. The new texture will not be smoothed.
sprite.texture = Texture(from: sprite.texture!)
sprite.resetTextureRect()


/// The event storage.
var event = Event.unknown
/// The main window.
var window = RenderWindow(
    mode: VideoMode(width: 640, height: 480, bitsPerPixel: 32), 
    title: "SwiftSFML Demo",
    style: .defaultStyle,
    settings: settings
)

// Main loop
while window.isOpen {
    // We poll all the event that occureed since the last iteration.
    while window.poll(event: &event) {
        switch event {
        case .closed:
            // We close the window, which will break the main loop.
            window.close()
        case let .resized(width, height):
            print("Resized \(width) - \(height)")
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
            case .r:
                // Resets the texture rect of the cicle.
                circle.resetTextureRect()
            case .s:
                // We toggle the smoothness of the texture.
                texture!.isSmooth.toggle()
            case .t:
                // We toggle the appearance of the texture.
                showTexture.toggle()
                circle.texture = showTexture == true ? texture : nil
                circle.textureRect = RectI(left: 0, top: 0, width: 128, height: 128)
            default:
                break
            }
        default:
            break
        }
    }

    // We clear the content of the window.
    window.clear(fillColor: Color(h: currentHue, s: 1, v: 1))
    // We draw inside it.
    window.draw(circle)
    window.draw(sprite, renderState: state)
    window.draw(sprite2)
    // We update the on-screen content.
    window.display()
}
