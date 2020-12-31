// StringExtension.swift
// Created by Jérémy Goyette
// On 2020/12/31
// For SwiftSFML

extension String {
    /// The UTF-32 Representation of the string
    public var utf32: [UInt32] {
        var result = [UInt32]()
        for v in self.unicodeScalars {
            result.append(v.value)
        }

        return result
    }
}