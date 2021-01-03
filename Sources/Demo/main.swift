import SwiftSFML

print("Hello")

var event = Event.unknown
var window = RenderWindow(mode: VideoMode(width: 640, height: 480, bitsPerPixel: 32), title: "SwiftSFML Demo")

while window.isOpen {
    while window.poll(event: &event) {
        switch event {
        case .closed:
            window.close()
        default:
            break
        }
    }
}
