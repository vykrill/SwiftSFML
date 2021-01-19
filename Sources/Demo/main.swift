import SwiftSFML
import Foundation

print("Hello")
/*
struct RectanglePrimitive: VertexArray {
    
    var vertices: [Vertex] {
        get {
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
        set {}
    }
    let type = PrimitiveType.quads

    var rect: RectF
    var color: Color = .white

}*/



/// The stating width of the window.
let defaultWidth: UInt32 = 640
/// The starting height of the window.
let defaultHeight: UInt32 = 480

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
// settings.antialiasingLevel = 8

/// Transform of sprite 2
let transform = Transform()
    .translated(by: Vector2F(x: Float(defaultWidth / 2), y: Float(defaultHeight / 2)))
    .scaled(by: Vector2F(x: 1.5, y: 1.5))

print(transform)

var state = RenderState(transform)

// Sprite

var sprite = Sprite(from: texture!)
sprite.origin = Vector2F(x: sprite.localBounds.width / 2, y: sprite.localBounds.height / 2)


/// A rectangle
var rect = RectangleShape(rect: RectF(left: 0, top: 0, width: Float(defaultWidth), height: Float(defaultHeight)))
//RectangleShape(rect: RectF(left: 0, top: 0, width: Float(defaultWidth), height: Float(defaultHeight)))

guard let rectTexture = Texture(fromURL: Bundle.module.url(forResource: "vertexTexture", withExtension: "png")!) else {
    fatalError("Impossible to load 'vertexTexture.png'")
}
rectTexture.isSmooth = true
rectTexture.isRepeated = true
let rectState = RenderState(rectTexture)

/// The event storage.
var event = Event.unknown
/// The main window.
var window = RenderWindow(
    mode: VideoMode(width: defaultWidth, height: defaultHeight, bitsPerPixel: 32),
    title: "SwiftSFML Demo - \(defaultWidth) x \(defaultHeight)",
    style: .defaultStyle,
    settings: settings
)
window.setFramerate(limit: 60)

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
            case .s:
                // We toggle the smoothness of the texture.
                rectTexture.isSmooth.toggle()
            default:
                break
            }
        default:
            break
        }
    }

    rect.setColor(to: Color(h: currentHue, s: 1, v: 1))

    // We spin `sprite`.
    state.transform.rotate(
        by: 1
    )

    // We clear the content of the window.
    window.clear()
    // We draw inside it.
    window.draw(rect, renderState: rectState)
    window.draw(sprite, renderState: state)
    // We update the on-screen content.
    window.display()
}
