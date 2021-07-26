// Keyboard.swift
// Created by Jeremy Goyette
// On 2021/07/25
// For SwiftSFML

import CSFML
import Foundation

/// Gives access to the real-time state of the keyboard.
public struct Keyboard {
    
    /// Checks if a key is pressed.
    ///
    /// > Tip: Subscript notation is also supported
    /// > ```swift
    /// > // These lines do the same thing.
    /// > let _ = Keyboard.isKeyPressed(.a)
    /// > let _ = Keyboard[.a]
    /// > ```
    static public func isKeyPressed(_ key: Code) -> Bool {
        return sfKeyboard_isKeyPressed(sfKeyCode(rawValue: key.rawValue)) != 0
    }

    /// Checks if a key is pressed.
    static public subscript(key: Code) -> Bool { isKeyPressed(key) }

    public enum Code: Int32 {
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
    }
}