//
//  ContentView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Germany")
                .font(AppFonts.customFont(.ibmPlexSans, .semiBold, size: 15))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
