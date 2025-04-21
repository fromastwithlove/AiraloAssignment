//
//  NavigationBarModifier.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    init() {
        /// Customisation for navigation bar appearance

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        
        /// Text styling
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 32
        paragraphStyle.maximumLineHeight = 32
        paragraphStyle.alignment = .left
        
        appearance.titleTextAttributes = [
            .font: UIFont.ibmPlexSans(.medium, size: 14),
            .foregroundColor: UIColor.tintColor,
            .kern: -0.5,
            .paragraphStyle: paragraphStyle
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont.ibmPlexSans(.semiBold, size: 27),
            .foregroundColor: UIColor.tintColor,
            .kern: -0.5,
            .paragraphStyle: paragraphStyle,
        ]
        
        /// Set the back button appearance and hide title
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backButtonAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        /// Set the back button image with rendering mode
        if let backButtonImage = UIImage(named: "ic_back_header")?.withRenderingMode(.alwaysTemplate) {
            UINavigationBar.appearance().backIndicatorImage = backButtonImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        }
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color.white
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
