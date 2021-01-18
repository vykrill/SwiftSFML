import SwiftSFML
import Foundation

print("Hello")

struct RectanglePrimitive: VertexArray {
    var vertices: [Vertex] {
        return [
            Vertex(position: Vector2F(x: rect.left, y: rect.top), color: color,
                texCoords: Vector2F(x: 0, y:0)),
            Vertex(position: Vector2F(x: rect.left + rect.width, y: rect.top), color: color,
                texCoords: Vector2F(x: rect.width / 2, y:0)),
            Vertex(position: Vector2F(x: rect.left + rect.width, y: rect.top + rect.height), color: color, 
                texCoords: Vector2F(x: rect.width / 2, y: rect.height / 2)),
            Vertex(position: Vector2F(x: rect.left, y: rect.top + rect.height), color: color, 
                texCoords: Vector2F(x: 0, y: rect.height / 2))
        ]
    }
    let type = PrimitiveType.quads

    var rect: RectF
    var color: Color = .white

}

/// The stating width of the window.
let defaultWidth = 640
/// The starting height of the window.
let defaultHeight = 480

/// The radius of the circle.
let radius: Float = 100.0
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
circle.position = Vector2F(x: Float(defaultWidth) - radius - 25, y: radius + 25)
// Appearance of the circle.
circle.outlineColor = .black
circle.outlineThickness = 10.0
circle.fillColor = .white
circle.pointCount = 80
// Texture of the circle
circle.texture = texture
circle.textureRect = RectI(left: 0, top: 0, width: 128, height: 128)

/// Transform of sprite 2
let transform = Transform()
    .translated(by: Vector2F(x: 64, y: 64))
    .scaled(by: Vector2F(x: 1.5, y: 1.5), withCenter: Vector2F(x: 128, y: 128))
    .rotated(by: 45, withCenter: Vector2F(x: 128, y: 128))

print(transform)

var state = RenderState(transform)

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

/// A rectangle
var rect = RectanglePrimitive(rect: RectF(left: 0, top: 0, width: Float(defaultWidth), height: Float(defaultHeight)))
rect.color = .green

let rectTexture = Texture(fromURL: Bundle.module.url(forResource: "vertexTexture", withExtension: "png")!)!
rectTexture.isSmooth = true
rectTexture.isRepeated = true
let rectState = RenderState(rectTexture)
print(rectState.texture)

/// The event storage.
var event = Event.unknown
/// The main window.
var window = RenderWindow(
    mode: VideoMode(width: 640, height: 480, bitsPerPixel: 32), 
    title: "SwiftSFML Demo",
    style: .defaultStyle,
    settings: settings
)

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
            print("Resized \(width) - \(height)")
            window.setTitle(to: "SwiftSFML Demo - \(width) x \(height)")
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

    rect.color = Color(h: currentHue, s: 1, v: 1)

    // We spin `sprite`.
    state.transform.rotate(
        by: 0.01, 
        withCenter: Vector2F(x: sprite.globalBounds.width / 2, y: sprite.globalBounds.height / 2)
    )

    // We clear the content of the window.
    window.clear()
    // We draw inside it.
    window.draw(rect, renderState: rectState)
    window.draw(circle)
    window.draw(sprite, renderState: state)
    window.draw(sprite2)
    // We update the on-screen content.
    window.display()
}
