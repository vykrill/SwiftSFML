// Event.swift
// Created by Jérémy Goyette
// On 2020/12/31
// For SwiftSFML

import CSFML

public enum Event {
    case closed
    case resized(width: UInt32, height: UInt32)
    
    case lostFocus
    case gainedFocus
    
    case textEntered(unicode: UInt32)
    
    case keyPressed( data: Key)
    case keyReleased(data: Key)
    
    case mouseWheelScrolled
    
    case mouseButtonPressed( data: MouseButton)
    case mouseButtonReleased(data: MouseButton)
    
    case mouseMoved(x: Int, y: Int)
    
    case mouseEntered
    case mouseLeft
    
    case joystickButtonPressed( data: JoystickButton)
    case joystickButtonReleased(data: JoystickButton)
    
    case joystickMoved(data: JoystickMove)
    
    case joystickConnected(   joystickID: UInt32)
    case joystickDisconnected(joystickID: UInt32)
    
    case touchBegan(data: Touch)
    case touchMoved(data: Touch)
    case touchEnded(data: Touch)
    case sensorChanged
    // case count

    public struct JoystickButton {
        public var joystickID: UInt32
        public var button: UInt32
    }

    public struct JoystickMove {
        public var joystickID: UInt32
        public var axis: Axis
        public var position: Float

        public enum Axis {
            case x
            case y
            case z
            case r
            case u
            case v
            case povX
            case povY
        }
    }

    public struct Key {
        public var code: Code
        public var alt: Bool
        public var control: Bool
        public var shift: Bool
        public var system: Bool

        public enum Code {
            case unknown = -1
            case a
            case b
            case c
            case d
            case e
            case f
            case g
            case h
            case i
            case j
            case k
            case l
            case m
            case n
            case o
            case p
            case q
            case r
            case s
            case t
            case u
            case v
            case w
            case x
            case y
            case z
            case num0
            case num1
            case num2
            case num3
            case num4
            case num5
            case num6
            case num7
            case num8
            case num9
            case escape
            case lControl
            case lShift
            case lAlt
            case lSystem
            case rControl
            case rShift
            case rAlt
            case rSystem
            case menu
            case lBracket
            case rBracket
            case semiColon
            case comma
            case period
            case quote
            case slash
            case backSlash
            case tilde
            case equal
            case dash
            case space
            case `return`
            case back
            case tab
            case pageUp
            case pageDown
            case end
            case home
            case insert
            case delete
            case add
            case subtract
            case multiply
            case divide
            case left
            case right
            case up
            case down
            case numpad0
            case numpad1
            case numpad2
            case numpad3
            case numpad4
            case numpad5
            case numpad6
            case numpad7
            case numpad8
            case numpad9
            case f1
            case f2
            case f3
            case f4
            case f5
            case f6
            case f7
            case f8
            case f9
            case f10
            case f11
            case f12
            case f13
            case f14
            case f15
            case pause
            case count
        }        
    }

    public struct MouseButton {
        public enum Button {
            case left
            case right
            case middle
            case xButton1
            case xButton2
            // case count
        }
    }

    public struct Touch {
        public var finger: UInt32
        public var x: Int
        public var y: Int
    }

}