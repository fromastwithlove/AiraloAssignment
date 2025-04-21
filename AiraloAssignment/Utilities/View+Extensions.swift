//
//  View+View+Extensions.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import SwiftUI

extension View {
    /// Applies a custom navigation bar appearance using `NavigationBarModifier`.
    func setupNavigationBar() -> some View {
        self.modifier(NavigationBarModifier())
    }
}
