// RenderWindow.swift
// Created by Jérémy Goyette
// On 2020/12/31
// For SwiftSFML

import CSFML
import Foundation

/// A window that can serve as a target for 2D rendering.
public class RenderWindow {
    /// The underlying SFML `sf::RenderWindow` instance.
    internal var window: OpaquePointer

    // MARK: Properties

    /// Whether the render window has the input focus.
    ///
    /// At any given time, only one window may have the input
    ///  focus to receive input events such as keystrokes or most mouse events.
    ///
    /// `true` if the window has focus, `false` otherwise. 
    public var hasFocus: Bool { 
        sfRenderWindow_hasFocus(self.window) != 0
    }

    /// Whether the window is opened or not.
    public var isOpen: Bool {
        sfRenderWindow_isOpen(self.window) != 0
    }

    /// The position of the `RenderWindow` in pixels.
    ///
    /// Modifying the position only work on top level windows.
    public var position: Vector2I {
        get { sfRenderWindow_getPosition(self.window) }
        set { sfRenderWindow_setPosition(self.window, newValue) }
    }

    /// The size of the rendering region of the window.
    public var size: Vector2U {
        get { sfRenderWindow_getSize(self.window) }
        set { sfRenderWindow_setSize(self.window, newValue) }
    }

    /// The creation settings of the window.
    public var settings: ContextSettings { 
        sfRenderWindow_getSettings(self.window)
    }

    // MARK: Initialisation and deinitialisation
    /// Creates a new window.
    ///
    /// - parameters:
    ///     - mode: The video mode to use.
    ///     - title: The title of the window.
    ///     - style: The style of the window (defaults to .defaultStyle).
    ///     - settings: Creation settings (defaults to the default settings).
    public init(mode: VideoMode, title: String, 
                style: WindowStyle = .defaultStyle, 
                settings: ContextSettings = ContextSettings()) {
        
        // We can do this since the settings are not modified in the CSFML function.
        var settingsCopy = settings

        // The creation of the window.
        self.window = sfRenderWindow_createUnicode(mode, title.utf32, style.rawValue, &settingsCopy)
    }

    deinit {
        sfRenderWindow_destroy(self.window)
    }

    // MARK: Methods
    /// Close the render window, but does not destroy the internal data.
    public func close() {
        sfRenderWindow_close(self.window)
    }

    /// Update and display the render window on screen.
    public func display() {
        sfRenderWindow_display(self.window)
    }

    /// Gets the default view of the window.
    ///
    /// It is the view used by the `RenderWindow` if you don't use `setView`. It maches the the window's size 1:1.
    /// This can be useful if you want to define your own view based on it, or restore it to draw fixed entities
    /// (like a GUI) on top of your scene. 
    ///
    /// - returns: The default view of the render window 
    public func getDefaultView() -> View {
        View(sfRenderWindow_getDefaultView(self.window))
    }

    /// Get the current active view of the render window. 
    ///
    /// - returns: The active view of the window.
    public func getView() -> View {
        View(sfRenderWindow_getView(self.window))
    }

    /// Convert a point from world coordinates to window coordinates.
    /// 
    /// This function finds the pixel of the render-window that matches the given 2D point. In other words, it goes
    /// through the same process as the graphics card, to compute the final position of a rendered point.
    /// 
    /// Initially, both coordinate systems (world units and target pixels) match perfectly. But if you define a custom
    /// view or resize your render-window, this assertion is not true anymore, ie. a point located at (150, 75) in
    /// your 2D world may map to the pixel (10, 50) of your render-window – if the view is translated by (140, 25).
    ///
    /// - parameters:
    ///     - point: The point to convert.
    ///     - view: The view to use to convert the point. If set to `nil`, the function uses the current view of the
    ///             render window.
    ///
    /// - returns: The converted point in pixels.
    public func mapCoordsToPixel(_ point: Vector2F, view: View? = nil) -> Vector2I {
        if let csfmlView = view?.view {
            return sfRenderWindow_mapCoordsToPixel(self.window, point, csfmlView)
        } else {
            let winView = self.getView()
            return sfRenderWindow_mapCoordsToPixel(self.window, point, winView.view)
        }
    }

    /// Convert a point from window coordinates to world coordinates.
    /// 
    /// This function finds the 2D position that matches the given pixel of the render-window. In other words,
    /// it does the inverse of what the graphics card does, to find the initial position of a rendered pixel.
    /// 
    /// Initially, both coordinate systems (world units and target pixels) match perfectly. But if you define a custom
    /// view or resize your render-window, this assertion is not true anymore, ie. a point located at (10, 50) in your
    /// render-window may map to the point (150, 75) in your 2D world – if the view is translated by (140, 25).
    /// 
    /// This function is typically used to find which point (or object) is located below the mouse cursor.
    ///
    /// - parameters: 
    ///     - pixel: The pixel position to convert.
    ///     - view: The view used to do the conversion. If set to `nil`, the function will use the current view of the 
    ///             render window.
    ///
    /// - returns: The converted point in "world" units.
    public func mapPixelToCoords(_ pixel: Vector2I, view: View? = nil) -> Vector2F {
        if let csfmlView = view?.view {
            return sfRenderWindow_mapPixelToCoords(self.window, pixel, csfmlView)
        } else {
            let view2 = self.getView()
            return sfRenderWindow_mapPixelToCoords(self.window, pixel, view2.view)
        }
    }

    /// Request the current render window to be made the active foreground window.
    ///
    /// At any given time, only one window may have the input focus to receive input events such as keystrokes or
    /// mouse events. If a window requests focus, it only hints to the operating system, that it would like to be
    /// focused. The operating system is free to deny the request.
    public func requestFocus() {
        sfRenderWindow_requestFocus(self.window)
    }

    /// Limit the framerate to a maximum fixed frequency for a render window. 
    ///
    /// - parameter limit: Framerate limit in FPS. Must be at least `1`.
    ///                     Set to `nil` to disable the limit.
    public func setFramerate(limit: UInt32?) {
        assert(limit ?? 1 > 0, "The framerate limit must be set to at least 1 (use nil to disable).")
        sfRenderWindow_setFramerateLimit(self.window, limit ?? 0)
    }

    /// Change the joystick threshold.
    ///
    /// The joystick threshold is the value below which no JoystickMoved event will be generated.
    /// 
    /// The threshold value is 0.1 by default.
    ///
    /// - parameter threshold: The new threshold, in the range [0, 100]
    public func setJoystickThreshold(to threshold: Float) {
        sfRenderWindow_setJoystickThreshold(self.window, threshold)
    }

    /// Enable or disable automatic key-repeat.
    /// 
    /// If key repeat is enabled, you will receive repeated KeyPressed events while keeping a key pressed. If it is
    /// disabled, you will only get a single event when the key is pressed.
    /// 
    /// Key repeat is enabled by default.
    ///
    /// - parameter enabled: `true` to enable, `false` to disable.
    public func setKeyRepeat(to enabled: Bool) {
        sfRenderWindow_setKeyRepeatEnabled(self.window, enabled == true ? 1 : 0)
    }

    /// Changes the `RenderWindow`'s icon.
    ///
    /// - parameter image: The image that will be used as the new icon.
    public func setIcon(to image: Image) {
        sfRenderWindow_setIcon(self.window, image.size.x, image.size.y, image.getPixels())
    }

    /// Grab or release the mouse cursor.
    ///
    /// If set, grabs the mouse cursor inside this window's client area so it may no longer be moved outside its bounds.
    /// Note that grabbing is only active while the window has focus and calling this function for fullscreen windows
    /// won't have any effect (fullscreen windows always grab the cursor).
    ///
    /// - parameter grabbed: `true` to enable, `false` to disable.
    public func setMouseCursorGrabbed(to grabbed: Bool) {
        sfRenderWindow_setMouseCursorGrabbed(self.window, grabbed == true ? 1 : 0)
    }

    /// Show or hide the mouse cursor. 
    ///
    /// - parameter visible: `true` to show, `false` to hide.
    public func setMouseCursorVisible(to visible: Bool) {
        sfRenderWindow_setMouseCursorVisible(self.window, visible == true ? 1 : 0)
    }

    /// Change the title of the window.
    ///
    /// - parameter title: The new title.
    public func setTitle(to title: String) {
        sfRenderWindow_setUnicodeTitle(self.window, title.utf32)
        // sfRenderWindow_setUnicodeTitle(self.window,[0x61, 0x61, 0x61, 0x61, 0x61])
    }

    /// Enable / disable vertical synchronization on a render window. 
    ///
    /// - parameter enabled: `true` to enable V-Sync, `false` to disable it.
    public func setVerticalSync(enabled: Bool) {
        sfRenderWindow_setVerticalSyncEnabled(self.window, enabled == true ? 1 : 0)
    }

    /// Changes the current active view of a window.
    ///
    /// When you call `setView`, the render-target makes a copy of the view, and doesn't store a pointer to the one that
    /// is passed. This means that whenever you update your view, you need to call setView again to apply the
    /// modifications.
    ///
    ///
    /// Don't be afraid to copy views or create them on the fly, they aren't expensive objects (they just hold a
    /// few floats).
    ///
    /// - parameter view: The view to apply. 
    public func setView(to view: View) {
        sfRenderWindow_setView(self.window, view.view)
    }

    /// Show or hide a render window. 
    ///
    /// - parameter visibility: `true` to show the window, `false` to hide it.
    public func setVisible(to visibility: Bool) {
        sfRenderWindow_setVisible(self.window, visibility == true ? 1 : 0)
    }

    // MARK - Event handling
    /// Pop the event on top of the event queue, if any, and return it. 
    ///
    /// This function is not blocking: if there's no pending event then it will return `false` and leave `event`
    /// unmodified. Note that more than one event may be present in the event queue, thus you should always
    /// call this function in a loop to make sure that you process every pending event. 
    ///
    /// **Example**
    ///
    ///     var event = Event.unknown
    ///     while window.poll(event) {
    ///         // Process event...
    ///     }
    ///
    /// - parameter event: The event that will be popped out of the queue.
    /// - returns: `false` if no new event occured since last call, otherwise `true`.
    /// - SeeAlso: wait(event:)
    public func poll(event: inout Event) -> Bool {
        var cEvent = sfEvent()
        let returnValue = sfRenderWindow_pollEvent(self.window, &cEvent) != 0
        event = translate(cEvent)
        return returnValue
    }

    /// Wait for an event and return it.
    ///
    /// This function is blocking: if there's no pending event then it will wait until an event is received. After this
    /// function returns (and no error occurred), the `event` instance is always valid and filled properly. This function is
    /// typically used when you have a thread that is dedicated to events handling: you want to make this thread sleep
    /// as long as no new event is received. 
    ///
    /// - parameter event: The event to be returned.
    /// - returns: `false` if an error occured.
    /// - SeeAlso: poll(event:)
    public func wait(event: inout Event) -> Bool {
        var csfmlEvent = sfEvent()
        let returnValue = sfRenderWindow_waitEvent(self.window, &csfmlEvent) != 0
        event = translate(csfmlEvent)
        return returnValue
    }

    /// Translates event data from CSFML into SwiftSFML `Event`.
    /// - parameter csfmlEvent: A `sfEvent` coming straight from CSFML.
    /// - returns: The corresponding `Event`, or `.unknown` if the event is not recognized by SwiftSFML.
    private func translate(_ csfmlEvent: sfEvent) -> Event {
        switch csfmlEvent.type {
        case sfEvtClosed:
            return .closed
        case sfEvtResized:
            return .resized(width: csfmlEvent.size.width, height: csfmlEvent.size.height)
        case sfEvtLostFocus:
            return .lostFocus
        case sfEvtGainedFocus:
            return .gainedFocus
        case sfEvtTextEntered:
            return .textEntered(unicode: csfmlEvent.text.unicode)
        case sfEvtKeyPressed:
            return .keyPressed(data: Event.KeyData(from: csfmlEvent))
        case sfEvtKeyReleased:
            return .keyReleased(data: Event.KeyData(from: csfmlEvent))
        case sfEvtMouseWheelScrolled:
            return .mouseWheelScrolled(data: Event.MouseWheelScrollData(from: csfmlEvent))
        case sfEvtMouseButtonPressed:
            return .mouseButtonPressed(data: Event.MouseButtonData(from: csfmlEvent))
        case sfEvtMouseButtonReleased:
            return .mouseButtonReleased(data: Event.MouseButtonData(from: csfmlEvent))
        case sfEvtMouseMoved:
            return .mouseMoved(x: Int(csfmlEvent.mouseMove.x), y: Int(csfmlEvent.mouseMove.y))
        case sfEvtMouseEntered:
            return .mouseEntered
        case sfEvtMouseLeft:
            return .mouseLeft
        case sfEvtJoystickButtonPressed:
            return .joystickButtonPressed(data: Event.JoystickButtonData(from: csfmlEvent))
        case sfEvtJoystickButtonReleased:
            return .joystickButtonReleased(data: Event.JoystickButtonData(from: csfmlEvent))
        case sfEvtJoystickMoved:
            return .joystickMoved(data: Event.JoystickMoveData(from: csfmlEvent))
        case sfEvtJoystickConnected:
            return .joystickConnected(joystickID: UInt(csfmlEvent.joystickConnect.joystickId))
        case sfEvtJoystickDisconnected:
            return .joystickDisconnected(joystickID: UInt(csfmlEvent.joystickConnect.joystickId))
        case sfEvtTouchBegan:
            return .touchBegan(data: Event.TouchData(from: csfmlEvent))
        case sfEvtTouchMoved:
            return .touchMoved(data: Event.TouchData(from: csfmlEvent))
        case sfEvtTouchEnded:
            return .touchEnded(data: Event.TouchData(from: csfmlEvent))
        case sfEvtSensorChanged:
            return .sensorChanged(data: Event.SensorData(from: csfmlEvent))
        default: 
            return .unknown
        }
    }

    // MARK: Graphics
    /// Clear the entire target with a single color. 
    ///
    /// This function is usually called once every frame, to clear the previous contents of the window.
    ///
    /// - parameter fillColor: The color used to clear the window.
    public func clear(fillColor: Color = Color.black) {
        sfRenderWindow_clear(self.window, fillColor)
    }
    
    /// Draw a `CircleShape` in the window.
    ///
    /// - parameter shape: The shape to draw.
    /// - parameter renderState: The render state to use for drawing.
    public func draw(_ shape: CircleShape, renderState: RenderState = .default) {
        var state = renderState.csfmlRenderState
        sfRenderWindow_drawCircleShape(self.window, shape.shape, &state)
    }

    /// Draw a `Sprite` in the window.
    ///
    /// - parameter sprite: The sprite to draw.
    /// - parameter renderState: The render state to use for drawing.
    public func draw(_ sprite: Sprite, renderState: RenderState = .default) {
        var state = renderState.csfmlRenderState
        sfRenderWindow_drawSprite(self.window, sprite.sprite, &state)
    }

    /// Draws a vertex array in the window.
    ///
    /// - parameters:
    ///     - vertextArray: The `VertexArray` to draw.
    ///     - renderState: The render state to use for drawing.
    public func draw(_ vertexArray: VertexArray, renderState: RenderState = .default) {
        var state = renderState.csfmlRenderState
        sfRenderWindow_drawPrimitives(
            self.window,
            vertexArray.vertices, 
            vertexArray.vertices.count, 
            sfPrimitiveType(rawValue: vertexArray.type.rawValue), 
            &state
        )
    }
    
    /// Draws a drawable object in the window.
    ///
    /// - parameters:
    ///     - other: The `Drawable` object to draw.
    ///     - renderState: Various parameters used for rendering.
    ///                     Note that `renderState.texture` will be used if it is not set to `nil`. Furthermore, `other.transform` will be combined with `renderState.transform`.
    public func draw(_ other: Drawable, renderState: RenderState = .default) {
        var state = renderState
        state.transform = other.transform.combined(with: renderState.transform)
        if state.texture == nil {
            state.texture = other.texture
        }
        
        self.draw(other as VertexArray, renderState: renderState)
    }
}
