import SwiftSFML

print("Hello")

let defaultWidth = 640
let defaultHeight = 480

/// The radius of the circle.
let radius: Float = 50.0
let minSize = UInt32(2 * radius)

var currentHue: Double = 0

var settings = ContextSettings()
settings.antialiasingLevel = 8

// Circle shape
var circle = CircleShape(radius: radius)
circle.origin = Vector2F(x: radius, y: radius)
circle.position = Vector2F(x: Float(defaultWidth) / 2, y: Float(defaultHeight) / 2)
circle.outlineColor = .black
circle.outlineThickness = 10.0
circle.fillColor = .white

var event = Event.unknown
var window = RenderWindow(
    mode: VideoMode(width: 640, height: 480, bitsPerPixel: 32), 
    title: "SwiftSFML Demo",
    style: .defaultStyle,
    settings: settings
)

while window.isOpen {
    while window.poll(event: &event) {
        switch event {
        case .closed:
            window.close()
        case let .resized(width, height):
            // window.setTitle(to: "SwiftSFML Demo - w: \(width), h: \(height) é".utf8CString)
            window.setTitle(to: "SwiftSFML Demo - w: \(width), h: \(height) é")
        case let .keyPressed(data):
            // We can change the window background with le left and right arrows.
            switch data.code {
            case .left:
                currentHue -= 1
                if currentHue < 0 { currentHue = 359}
            case .right:
                currentHue += 1
                if currentHue >= 360 { currentHue = 0}
            default:
                break
            }
        default:
            break
        }
    }
    window.clear(fillColor: Color(h: currentHue, s: 1, v: 1))

    window.draw(circle)

    window.display()
}
