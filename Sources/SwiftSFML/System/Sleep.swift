// Sleep.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

/// Make the current thread sleep for the given duration.
///
/// 'sleep' is the best way to block a program or one of its thread,
///  as its doesn't consume any CPU power.
///
/// - parameter duration: The sleep duration.
public func sleep(_ duration: Time) {
    sfSleep(duration)
}