//
//  LaunchView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

/// This view has been created for fun and displays the Airalo app icon along with a progress indicator.
/// It consists of an image (the Airalo app icon) and a `ProgressView` that shows a loading state.
struct LaunchView: View {
    var body: some View {
        VStack(spacing: .zero) {
            Image("LaunchIcon")
                .resizable()
                .frame(width: 150, height: 150)
            ProgressView()
        }
    }
}
