//
//  AsyncImageView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

/// A reusable image view that loads an image asynchronously with loading and error states.
struct AsyncImageView<I: View> : View {
    
    @StateObject var model: AsyncImageViewModel
    let imageContent: (Image) -> I
    
    var body: some View {
        switch model.imageState {
        case .empty:
            EmptyView()
        case .loading:
            ProgressView()
                .tint(.accentColor)
        case .success(let image):
            imageContent(image)
        case .error(let error):
            Text(verbatim: error.localizedDescription)
                .font(.ibmPlexSans(.thin, size: 10))
                .multilineTextAlignment(.leading)
        }
    }
}
