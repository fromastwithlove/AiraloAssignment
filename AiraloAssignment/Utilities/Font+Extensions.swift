//
//  Font+Extensions.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

import SwiftUI
import UIKit

/// Extension to easily use IBMPlexSans font family for SwiftUI views.
extension Font {
    
    /// Returns the `IBMPlexSans` font with a specified weight and size for SwiftUI.
    /// - Parameters:
    ///   - weight: The desired font weight (default is `.medium`).
    ///   - size: The size of the font.
    /// - Returns: A `Font` for SwiftUI.
    static func ibmPlexSans(_ weight: IBMFontWeight = .medium, size: CGFloat) -> Font {
        return Font.custom(weight.postScriptName, size: size)
    }
}

/// Extension to easily use IBMPlexSans font family for UIKit views.
extension UIFont {
    
    /// Returns the `IBMPlexSans` font with a specified weight and size for UIKit.
    /// - Parameters:
    ///   - weight: The desired font weight (default is `.medium`).
    ///   - size: The size of the font.
    /// - Returns: A `UIFont` for UIKit.
    static func ibmPlexSans(_ weight: IBMFontWeight = .medium, size: CGFloat) -> UIFont {
        if let font = UIFont(name: weight.postScriptName, size: size) {
            return font
        } else {
            #if DEBUG
            fatalError("Failed to load IBM Plex Sans font with name: \(weight.postScriptName)")
            #else
            return UIFont.systemFont(ofSize: size)
            #endif
        }
    }
}

enum IBMFontWeight {
    case regular, thin, extraLight, light, medium, semiBold, bold

    var postScriptName: String {
        switch self {
        case .regular: return "IBMPlexSans-Regular"
        case .thin: return "IBMPlexSans-Thin"
        case .extraLight: return "IBMPlexSans-ExtraLight"
        case .light: return "IBMPlexSans-Light"
        case .medium: return "IBMPlexSans-Medium"
        case .semiBold: return "IBMPlexSans-SemiBold"
        case .bold: return "IBMPlexSans-Bold"
        }
    }
}
