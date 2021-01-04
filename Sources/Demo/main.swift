import SwiftSFML

print("Hello")

let defaultWidth = 640
let defaultHeight = 480

var event = Event.unknown
var window = RenderWindow(
    mode: VideoMode(width: 640, height: 480, bitsPerPixel: 32), 
    title: "SwiftSFML Demo - w: \(defaultWidth), h: \(defaultHeight) é"
)

while window.isOpen {
    while window.poll(event: &event) {
        switch event {
        case .closed:
            window.close()
         case let .resized(width, height):
            // window.setTitle(to: "SwiftSFML Demo - w: \(width), h: \(height) é".utf8CString)
            window.setTitle(to: "SwiftSFML Demo - w: \(width), h: \(height) é")
        default:
            break
        }
    }
    window.clear(fillColor: .red)
    window.display()
}
