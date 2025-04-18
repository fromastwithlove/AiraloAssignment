//
//  AppFonts.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

import SwiftUI

struct AppFonts {

    /// Supported custom font families in the app.
    enum FontFamily: String {
        case ibmPlexSans = "IBMPlexSans"
        
        var name: String {
            return self.rawValue
        }
    }
    
    /// Available font styles (weights) within a given font family.
    enum Style: String {
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
        
        var name: String {
            return self.rawValue
        }
    }
    
    /// Creates a scalable custom font using the specified font family, style, and size.
    ///
    /// This method constructs a `Font` using the provided custom font name and size.
    /// The font automatically scales to respect the user's Dynamic Type settings,
    /// using the `.body` text style as a reference.
    ///
    /// - Parameters:
    ///   - family: The font family to use (e.g., `.ibmPlexSans`).
    ///   - style: The specific font style within the family (e.g., `.medium`, `.semibold`).
    ///   - size: The base point size for the font.
    /// - Returns: A `Font` instance that scales with the system’s Dynamic Type settings.
    static func customFont(_ family: FontFamily, _ style: Style, size: CGFloat) -> Font {
        return Font.custom("\(family.name)-\(style.name)", size: size)
    }
}
