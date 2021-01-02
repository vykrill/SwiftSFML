// Event.swift
// Created by Jérémy Goyette
// On 2020/12/31
// For SwiftSFML

import CSFML

//TODO: Add an example.
/// defines a system event and its parameters.
///
/// `Event` instances are filled by the `pollEvent` (or `waitEvent`) function of the `RenderWindow` class. Only these
/// two functions can produce valid events.
///
/// **Example**
///
///
///
///
///
///
///
///
///
///
///
///
/// **See Also**
/// - SeeAlso: [Original Documentation](https://www.sfml-dev.org/tutorials/2.5/window-events.php)
public enum Event {
    /// The window requested to be closed.
    ///
    /// This event is triggered when the user wants to
    /// close the window, through any possible methods the window
    /// manager provides (*close* button, keyboard shortcut, etc.)
    /// This only represents a close request, the window is not yet
    /// closed when the event is recieved.
    ///
    /// Typical code will just call window.close() in reaction to this
    /// event, to actually close the window. However, you may also want
    /// to do something else first, like saving the current application
    /// state or asking the user what to do. If you don't do anything,
    /// the window remains open. 
    ///
    /// **Example**
    ///
    ///     if event == .closed {
    ///         window.close()
    ///     }
    ///
    /// **See Also**
    /// - SeeAlso: resized
    ///            lostFocus
    ///            gained focus
    case closed
    
    /// The window was resized.
    /// 
    /// This event is triggered when the window is 
    /// resized, either through user action or programmatically by
    /// calling window.setSize. 
    ///
    /// You can use this event to adjust the rendering settings:
    /// the viewport if you use OpenGL directly, or the current view
    /// if you use sfml-graphics. 
    ///
    /// **Example**
    ///
    ///     switch event { 
    ///     case let .resized(width, height):
    ///         print("New width:  \(width)")
    ///         print("New height: \(height)")
    ///     default: break
    ///     }
    ///
    /// - parameters:
    ///     - width: The new width in pixels.
    ///     - height: the new height in pixels.
    ///
    /// **See Also**
    /// - SeeAlso: closed
    ///            lostFocus
    ///            gained focus
    case resized(width: UInt32, height: UInt32)
    
    /// The window lost the focus.
    ///
    /// This event is triggered when the window loses focus, which
    /// happens when the user switches the currently active window.
    /// When the window is out of focus, it doesn't recieve
    /// keyboard events.
    ///
    /// This event can be used e.g. if you want to pause your game
    /// when the window is inactive.
    ///
    /// **Example**
    ///
    ///     if event == .lostFocus { 
    ///         myGame.pause()
    ///     }
    ///
    /// **See Also**
    /// - SeeAlso: closed
    ///            resized
    ///            gained focus
    case lostFocus
    /// The window gained focus.
    ///
    /// This event is triggered when the window gains focus, which
    /// happens when the user switches to currently active window.
    /// When the window is in focus, it recieves keyboard events.
    ///
    /// This event can be used e.g. if you want to resume your game
    /// when the window is active again.
    ///
    /// **Example**
    ///
    ///     if event == .gainedFocus { 
    ///         myGame.resume()
    ///     }
    ///
    /// **See Also**
    /// - SeeAlso: closed
    ///            resized
    ///            lostFocus
    case gainedFocus
    
    /// A character was typed.
    ///
    /// This event is triggered when a character is typed. This
    /// must not be confused with the `keyPressed` event:
    /// `textEntered`  interprets the user input and produces the
    /// appropriate printable character. For example, pressing '^'
    /// then 'e' on a French keyboard will produce two KeyPressed 
    /// events, but a single `textEntered` event containing the 'ê'
    /// character. It works with all the input methods provided by the
    /// operating system, even the most specific or complex ones.
    ///
    /// This event is typically used to catch user input in a text
    /// field. 
    ///
    /// - important:
    /// Many programmers use the `keyPressed` event to get user input,
    /// and start to implement crazy algorithms that try to interpret
    /// all the possible key combinations to produce correct
    /// characters. Don't do that! 
    ///
    /// **Example**
    ///
    ///     switch event { 
    ///     case let .textEntered(unicode):
    ///         let scalar = Unicode.Scalar(unicode)
    ///         print(scalar)
    ///     default: break 
    ///     }
    ///
    /// - parameter unicode: The unicode scalar of the character that was entrered.
    ///
    /// - SeeAlso: keyPressed
    ///            keyReleased
    case textEntered(unicode: UInt32)
    
    // TODO: correct doc.
    /// A key was pressed.
    ///
    /// This event is triggered when a keyboard key is pressed.
    ///
    /// If a key is held, multiple KeyPressed events will be generated,
    /// at the default operating system delay (ie. the same delay that
    /// applies when you hold a letter in a text editor). To disable 
    /// repeated KeyPressed events, you can call
    /// `window.setKeyRepeat(enabled: false)`. 
    ///
    /// This event is the one to use if you want to trigger an action
    /// exactly once when a key is pressed or released, like making a
    /// character jump with space, or exiting something with escape.
    /// 
    /// - remark: 
    /// Sometimes, people try to react to `keyPressed` events directly 
    /// to implement smooth movement. Doing so will not produce the
    /// expected effect, because when you hold a key you only get a
    /// few events (remember, the repeat delay). To achieve smooth
    /// movement with events, you must use a boolean that you set on
    /// `keyPressed` and clear on `keyReleased`; you can then move
    /// (independently of events) as long as the boolean is set.
    /// The other (easier) solution to produce smooth movement is to
    /// use real-time keyboard input with ~~sf::Keyboard~~ 
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .keyPressed(data):
    ///         if data.code == .escape {
    ///             print("The escape key was pressed.")
    ///         }
    ///         print("Control: \(data.control)")
    ///         print("    Alt: \(data.alt)")
    ///         print("  Shift: \(data.shift)")
    ///         print(" System: \(data.system)")
    ///     default: break
    ///     }
    ///
    /// - parameter data: Contains the code of the pressed key and the state of the modifier keys.
    ///
    /// - SeeAlso: textEntered
    ///            keyReleased
    /// - SeeAlso: Key
    case keyPressed(data: KeyData)
    /// A key was released.
    ///
    /// This event is triggered when a keyboard key is released.
    ///
    /// On the flip side of the `keyPressed` event, a `keyReleased`
    /// can never be repeated.
    ///
    /// This event is the one to use if you want to trigger an action
    /// exactly once when a key is pressed or released, like making a
    /// character jump with space, or exiting something with escape.
    /// 
    /// - remark: 
    /// Sometimes, people try to react to `keyPressed` events directly 
    /// to implement smooth movement. Doing so will not produce the
    /// expected effect, because when you hold a key you only get a
    /// few events (remember, the repeat delay). To achieve smooth
    /// movement with events, you must use a boolean that you set on
    /// `keyPressed` and clear on `keyReleased`; you can then move
    /// (independently of events) as long as the boolean is set.
    /// The other (easier) solution to produce smooth movement is to
    /// use real-time keyboard input with ~~sf::Keyboard~~ 
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .keyReleased(data):
    ///         if data.code == .escape {
    ///             print("The escape key was released.")
    ///             print("Control: \(data.control)")
    ///             print("    Alt: \(data.alt)")
    ///             print("  Shift: \(data.shift)")
    ///             print(" System: \(data.system)")
    ///         }
    ///     default: break
    ///     }
    ///
    /// - parameter data: Contains the code of the released key and the state of the modifier keys.
    ///
    /// - SeeAlso: textEntered
    ///            keyPressed
    /// - SeeAlso: Key
    case keyReleased(data: KeyData)
    
    // TODO: Add data to the event, add code example.
    /// The mouse wheel was scrolled.
    ///
    /// This event is triggered when a mouse wheel moves up or down,
    /// but also laterally if the mouse supports it. 
    /// 
    /// - parameter data: it contains the number of ticks the wheel has moved, what the orientation 
    ///                   of the wheel is and the current position of the mouse cursor. 
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .mouseWheelScrolled(data)
    ///         switch data.wheel {
    ///         case .vertical:     print("Wheel type: vertical.")
    ///         case .horizontal:   print("Wheel type: horizontal.")
    ///         }
    ///         print("Wheel movement: \(data.delta)")
    ///         print("Mouse position: (\(data.x), \(data.y)")
    ///     }
    ///
    /// - SeeAlso: MouseWheelPressed
    ///            mouseButtonReleased
    ///            mouseMoved
    ///            mouseEntered
    ///            mouseLeft
    /// - SeeAlso: MouseWheelScrollData
    case mouseWheelScrolled(data: MouseWheelScrollData)
    
    /// A mouse button was pressed.
    ///
    /// This event is triggered when a mouse button is pressed.
    ///
    /// SFML supports 5 mouse buttons: left, right, middle (wheel), extra #1 and extra #2 (side buttons). 
    ///
    /// - parameter data: Contains the code of the pressed button, as well as the position of the mouse cursor.
    ///
    /// **Example**
    /// 
    ///     switch event: 
    ///     case let .mouseButtonPressed(data):
    ///         if data.button == .right {
    ///             print("The right mouse button was pressed")
    ///             print("Position: (\(data.x); \(data.y))")
    ///         }
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: MouseWheelScrolled
    ///            mouseButtonReleased
    ///            mouseMoved
    ///            mouseEntered
    ///            mouseLeft
    case mouseButtonPressed(data: MouseButtonData)

    /// A mouse button was released.
    ///
    /// This event is triggered when a mouse button is released.
    ///
    /// SFML supports 5 mouse buttons: left, right, middle (wheel), extra #1 and extra #2 (side buttons). 
    ///
    /// - parameter data: Contains the code of the released button, as well as the position of the mouse cursor.
    ///
    /// **Example**
    /// 
    ///     switch event: 
    ///     case let .mouseButtonReleased(data):
    ///         if data.button == .right {
    ///             print("The right mouse button was released")
    ///             print("Position: (\(data.x); \(data.y))")
    ///         }
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: MouseWheelScrolled
    ///            mouseButtonPressed
    ///            mouseMoved
    ///            mouseEntered
    ///            mouseLeft
    /// - SeeAlso: MouseButton
    case mouseButtonReleased(data: MouseButtonData)

    /// The mouse cursor moved.
    ///
    /// This event is triggered when the mouse moves within the window. 
    ///
    /// This event is triggered even if the window isn't focused. However, it is triggered only when the mouse 
    /// moves within the inner area of the window, not when it moves over the title bar or borders.
    ///
    /// - parameters:
    ///     - x: The X position of the cursor relative to the window.
    ///     - y: The Y position of the cursor relative to the window.
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .mouseMoved(x, y):
    ///         print("X: \(x), Y: \(y)")
    ///     default: break
    ///     }
    /// 
    /// - SeeAlso: MouseWheelScrolled
    ///            mouseButtonPressed
    ///            mouseButtonReleased
    ///            mouseEntered
    ///            mouseLeft
    case mouseMoved(x: Int, y: Int)
    
    /// The mouse cursor entered the area of the window.
    ///
    /// This event is triggered when the mouse cursor enters the window.
    ///
    /// **Example**
    /// 
    ///     if event == .mouseEntered {
    ///         print("The mouse cursor has entered the window.")
    ///     }
    ///
    /// - SeeAlso: mouseWheelScrolled
    ///            mouseButtonPressed
    ///            mouseButtonReleased
    ///            mouseMoved
    ///            mouseLeft
    case mouseEntered
    
    /// The mouse cursor left the area of the window.
    ///
    /// This event is triggered when the mouse cursor leaves the window.
    ///
    /// **Example**
    /// 
    ///     if event == .mouseLeft {
    ///         print("The mouse cursor has leaved the window.")
    ///     }
    ///
    /// - SeeAlso: MouseWheelScrolled
    ///            mouseButtonPressed
    ///            mouseButtonReleased
    ///            mouseMoved
    ///            mouseEntered
    case mouseLeft
    
    /// A joystick button was pressed.
    ///
    /// This event is triggered when a joystick button is pressed.
    ///
    /// SFML supports up to 8 joysticks and 32 buttons.
    ///
    /// - parameter data: Contains the identifier of the joystick and the index of the button that was pressed.
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .joystickButtonPressed(data):
    ///         print("Joystick button pressed!")
    ///         print("Joystick id: \(data.joystickID)")
    ///         print("Button: \(data.buuton)")
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: joystickButtonReleased
    ///            joystickMoved
    ///            joystickConnected
    ///            joystickDisconnected
    /// - SeeAlso: JostickButton
    case joystickButtonPressed(data: JoystickButtonData)
    
    // A joystick button was released.
    ///
    /// This event is triggered when a joystick button is released.
    ///
    /// SFML supports up to 8 joysticks and 32 buttons.
    ///
    /// - parameter data: Contains the identifier of the joystick and the index of the button that was released.
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .joystickButtonReleased(data):
    ///         print("Joystick button released!")
    ///         print("Joystick id: \(data.joystickID)")
    ///         print("Button: \(data.buuton)")
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: joystickButtonPressed
    ///            joystickMoved
    ///            joystickConnected
    ///            joystickDisconnected
    /// - SeeAlso: JoystickButton
    case joystickButtonReleased(data: JoystickButtonData)
    
    /// The joystick moved along an axis.
    ///
    /// This event is triggered when a joystick axis moves.
    ///
    /// Joystick axes are typically very sensitive, that's why SFML uses a detection threshold to avoid spamming your
    /// event loop with tons of JoystickMoved events. This threshold can be changed with the
    /// `RenderWindow.setJoystickThreshold` function, in case you want to receive more or less joystick move events.
    ///
    /// SFML supports 8 joystick axes: X, Y, Z, R, U, V, POV X and POV Y. How they map to your joystick depends on its 
    /// driver.
    ///
    /// - parameter data: Contains the identifier of the joystick, the name of the axis and its current position (in 
    ///                     the range [-100, 100].
    ///
    /// **Example**
    ///
    ///     switch event {
    ///     case let .joystickMoved(data):
    ///         if data.axis == .x {
    ///             print("X axis moved!")
    ///             print("Joystick id: \(data.joystickID)")
    ///             print("New position: \(data.position")
    ///         }
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: joystickButtonPressed
    ///            joystickButtonReleased
    ///            joystickConnected
    ///            joystickDisconnected
    /// - SeeAlso: JostickMove
    case joystickMoved(data: JoystickMoveData)
    
    /// A joystick was connected.
    ///
    /// This event is triggered when a joystick is connected.
    ///
    /// - parameter joystickID: The identifier of the connected joystick.
    ///
    /// **Example**
    /// 
    ///     switch event {
    ///     case let .joystickConnected(id):
    ///         print("Joystick \(id) has been connected")
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: joystickButtonPressed
    ///            joystickButtonReleased
    ///            joystickMoved
    ///            joystickDisconnected
    case joystickConnected(joystickID: UInt32)
    /// A joystick was disconnected.
    ///
    /// This event is triggered when a joystick is disconnected.
    ///
    /// - parameter joystickID: The identifier of the disconnected joystick.
    ///
    /// **Example**
    /// 
    ///     switch event {
    ///     case let .joystickDisconnected(id):
    ///         print("Joystick \(id) has been disconnected")
    ///     default: break
    ///     }
    ///
    /// - SeeAlso: joystickButtonPressed
    ///            joystickButtonReleased
    ///            joystickMoved
    ///            joystickConnected
    case joystickDisconnected(joystickID: UInt32)
    
    /// A touch event began.
    case touchBegan(data: TouchData)
    /// A touch event ended.
    case touchMoved(data: TouchData)
    /// A touch event ended.
    case touchEnded(data: TouchData)
    /// A sensor value changed.
    case sensorChanged
    // case count

    /// Joystick buttons events parameters.
    ///
    /// Used by `joystickButtonPressed` and `joystickButtonReleased`.
    public struct JoystickButtonData {
        /// Index of the joystick.
        public var joystickID: UInt32
        /// Index of the button that has been pressed.
        public var button: UInt32
    }

    /// Joystick axis move event parameters.
    ///
    /// Used by `joystickMoved`.
    public struct JoystickMoveData {
        /// Index of the joystick.
        public var joystickID: UInt32
        /// Axis on which the joystick moved.
        public var axis: Axis
        /// The new position on the axis.
        ///
        /// The range is from -100 to 100.
        public var position: Float

        // TODO: Move it to a Joystick struct.
        /// The axes supported by SFML joystick.
        public enum Axis {
            /// The X axis.            
            case x
            /// The Y axis.            
            case y
            /// The Z axis.            
            case z
            /// The R axis.            
            case r
            /// The U axis.            
            case u
            /// The Y axis.            
            case v
            /// The X axis of the point-of-view hat. 
            case povX
            /// The Y axis of the point-of-view hat.
            case povY
        }
    }

    /// Keyboard events parameters.
    ///
    /// Used by `keyPressed` and `keyReleased` events. You do not create a KeyData instance directly. Instead, 
    /// you call `RenderWindow.pollEvent` or `RenderWindow.waitEvent` functions.
    public struct KeyData {
        /// The code of the key that has been pressed.
        public var code: Code
        /// If the *Alt* key is pressed
        public var alt: Bool
        /// If the *Control* key is pressed.
        public var control: Bool
        /// If the *Shift* key is pressed.
        public var shift: Bool
        /// If the system key is pressed.
        ///
        /// On macOS, it is the *Command* key. On Windows, it is the *Windows* key.
        /// On linux, it is the *Super* key (to be confirmed).
        public var system: Bool

        init(csfmlEvent source: sfEvent) {
            assert(source.type == sfEvtKeyPressed || source.type == sfEvtKeyReleased,
                "Fatal: Tried to create a Event.KeyData instance from invalid event")

            self.code = Code(rawValue: Int(source.key.code.rawValue))!
            self.alt =  source.key.alt != 0
            self.control =  source.key.control != 0
            self.shift = source.key.shift != 0
            self.system =  source.key.system != 0
        }

        // TODO: Move to a Keyboard struct.
        public enum Code: Int {
            /// Unhandled key.
            case unknown = -1
            /// The *A* key.
            case a
            /// The *B* key.
            case b
            /// The *C* key.
            case c
            /// The *D* key.
            case d
            /// The *E* key.
            case e
            /// The *F* key.
            case f
            /// The *G* key.
            case g
            /// The *H* key.
            case h
            /// The *I* key.
            case i
            /// The *J* key.
            case j
            /// The *K* key.
            case k
            /// The *L* key.
            case l
            /// The *M* key.
            case m
            /// The *N* key.
            case n
            /// The *O* key.
            case o
            /// The *P* key.
            case p
            /// The *Q* key.
            case q
            /// The *R* key.
            case r
            /// The *S* key.
            case s
            /// The *T* key.
            case t
            /// The *U* key.
            case u
            /// The *V* key.
            case v
            /// The *W* key.
            case w
            /// The *X* key.
            case x
            /// The *Y* key.
            case y
            /// The *Z* key.
            case z
            /// The *0* key.
            case num0
            /// The *1* key.
            case num1
            /// The *2* key.
            case num2
            /// The *3* key.
            case num3
            /// The *4* key.
            case num4
            /// The *5* key.
            case num5
            /// The *6* key.
            case num6
            /// The *7* key.
            case num7
            /// The *8* key.
            case num8
            /// The *9* key.
            case num9
            /// The *Escape* key.
            case escape
            /// The left *Control* key.
            case lControl
            /// The left *Shift* key.
            case lShift
            /// The left *Alt* key.
            case lAlt
            /// The left OS-specific key.
            ///
            /// *Windows* on Windows, *Command* on macOS, *Super* on Linux.
            case lSystem
            /// The right *Control* key.
            case rControl
            /// The right *Shift* key.
            case rShift
            /// The right *Alt* key.
            case rAlt
            /// The right *System* key.
            ///
            /// *Windows* on Windows, *Command* on macOS, *Super* on Linux.
            case rSystem
            /// The *Menu* key.
            case menu
            /// The [ key.
            case lBracket
            /// The ] key.
            case rBracket
            /// The ; key.
            case semiColon
            /// The , key.
            case comma
            /// The . key.
            case period
            /// The ' key.
            case quote
            /// The / key.
            case slash
            /// The \ key.
            case backSlash
            /// The ~ key.
            case tilde
            /// The = key.
            case equal
            /// The - key.
            case dash
            /// The *Space* key.
            case space
            /// The *Return* key.
            case `return`
            /// The *Backspace* key.
            case back
            /// The *Tabulation* key.
            case tab
            /// The *Page Up* key.
            case pageUp
            /// The *Page Down* key.
            case pageDown
            /// The *End* key.
            case end
            /// The *Home* key.
            case home
            /// The *Insert* key.
            case insert
            /// The *Delete* key.
            case delete
            /// The *+* key.
            case add
            /// The *-* key on the numpad.
            case subtract
            /// The * key.
            case multiply
            /// The */* key on the numpad.
            case divide
            /// The *Left Arrow* key.
            case left
            /// The *Right Arrow* key.
            case right
            /// The *Up Arrow* key.
            case up
            /// The *Down Arrow* key.
            case down
            /// The *0* key on the numpad.
            case numpad0
            /// The *1* key on the numpad.
            case numpad1
            /// The *2* key on the numpad.
            case numpad2
            /// The *3* key on the numpad.
            case numpad3
            /// The *4* key on the numpad.
            case numpad4
            /// The *5* key on the numpad.
            case numpad5
            /// The *6* key on the numpad.
            case numpad6
            /// The *7* key on the numpad.
            case numpad7
            /// The *8* key on the numpad.
            case numpad8
            /// The *9* key on the numpad.
            case numpad9
            /// The *F1* key.
            case f1
            /// The *F2* key.
            case f2
            /// The *F3* key.
            case f3
            /// The *F4* key.
            case f4
            /// The *F5* key.
            case f5
            /// The *F6* key.
            case f6
            /// The *F7* key.
            case f7
            /// The *F8* key.
            case f8
            /// The *F9* key.
            case f9
            /// The *F10* key.
            case f10
            /// The *F11* key.
            case f11
            /// The *F12* key.
            case f12
            /// The *F13* key.
            case f13
            /// The *F14* key.
            case f14
            /// The *F15* key.
            case f15
            /// The *Pause* key.
            case pause
            /// The ** key.
            // case count
        }        
    }

    // TODO: Move it to the Button struct.
    /// Mouse buttons.
    public struct MouseButtonData {

        public var button: Button
        public var x: Int
        public var y: Int

        public enum Button {
            /// The left mouse button.
            case left
            /// The right mouse button.
            case right
            /// The middle mouse button (wheel).
            case middle
            /// The first extra mouse button.
            case xButton1
            /// The second extra mouse button.
            case xButton2
            // case count
        }
    }

    public struct MouseWheelScrollData {

        /// The orientation of the wheel.
        public var wheel: Wheel
        /// Wheel ofset.
        ///
        /// Positive is up/left, negative is down/right. High-precision mice may use non-integral offsets.
        public var delta: Float
        /// X position of the mouse cursor.
        ///
        /// Relative to the top of the owner window.
        public var x: Int
        /// Y position of the mouse cursor.
        ///
        /// Relative to the top of the owner window.
        public var y: Int

        // TODO: Move to a Mouse struct
        /// Mouse wheels
        public enum Wheel {
            /// The vertical mouse wheel.
            case vertical
            /// The horizontal mouse wheel.
            case horizontal
        }
    }

    /// Touch event parameters.
    ///
    /// Used by `touchBegan`, `touchMoved` and `touchFinished`.
    public struct TouchData {
        /// The index of the finger in case of a multi-touch event.
        public var finger: UInt32
        /// X position of the touch, relative to the left of the owner window.
        public var x: Int
        /// Y position of the touch, relative to the top of the owner window.
        public var y: Int
    }

}