// StringExtension.swift
// Created by Jérémy Goyette
// On 2020/12/31
// For SwiftSFML

extension String {
    /// A UTF-32 encoding of `self`.
    public var utf32: [UInt32] { 
        var utf32 = self.unicodeScalars.map{ $0.value}
        utf32.append(0)
        return utf32
    }
}