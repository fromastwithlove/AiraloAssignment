//
//  Color+Extensions.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

extension Color {

    /// Initialises a Color from a hexadecimal string.
    /// - Parameter hex: Hex color string, e.g. "#FF5733".
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        
        let scanner = Scanner(string: hex)
        scanner.scanHexInt64(&rgb)

        let a, r, g, b: UInt64
        
        switch hex.count {
        // RGB (12-bit)
        case 3:
            (a, r, g, b) = (255, (rgb >> 8) * 17, (rgb >> 4 & 0xF) * 17, (rgb & 0xF) * 17)
        // RGB (24-bit)
        case 6:
            (a, r, g, b) = (255, rgb >> 16, rgb >> 8 & 0xFF, rgb & 0xFF)
        // ARGB (32-bit)
        case 8:
            (a, r, g, b) = (rgb >> 24, rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF)
        default:
            #if DEBUG
            fatalError("Invalid hex color string: \(hex)")
            #else
            self = .clear /// Fallback for production
            return
            #endif
        }

        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue:  Double(b) / 255,
                  opacity: Double(a) / 255
        )
    }
}
