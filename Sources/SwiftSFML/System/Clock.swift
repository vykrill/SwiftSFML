// Clock.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML


/// Utility class that measures the elapsed time.
/// 
/// It provides the most precise time that the underlying OS can achieve (generally microseconds or nanoseconds).
/// It also ensures monotonicity, which means that the returned time can never go backward, 
///  even if the system time is changed.
/// 
/// Usage example:
/// 
///      var clock = Clock()
///      let t1 = clock.elapsedTime
///      let t2 = clock.restart()
/// 
/// The `Time` value returned by the clock can then be converted to a number of seconds,
///  milliseconds or even microseconds.
public class Clock {
    private var data = sfClock_create()

    /// Get the time elapsed in the clock.
    /// 
    /// It is the time elapsed since the last call to the `restart` function
    ///  (or the construction of the object if `restart` has not been called).
    public var elapsedTime: Time { sfClock_getElapsedTime(data) }

    /// Restarts the clock.
    ///
    /// This function restarts the timer back to zero.
    /// - returns: The time elapsed since the clock was started.
    public func restart() -> Time {
        sfClock_restart(data)
    }

    deinit {
        sfClock_destroy(data)
    }
}