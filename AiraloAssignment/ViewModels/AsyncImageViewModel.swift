//
//  AsyncImageViewModel.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

@MainActor
@Observable
class AsyncImageViewModel: ObservableObject {
    
    // MARK: - Private Properties
    
    private let logger = AppLogger(category: "UI.AsyncImageViewModel")
    
    private let imageURLString: String
    private let networkService: NetworkServiceProtocol
    private(set) var imageState: ImageState = .empty
    
    init(imageURLString: String, networkService: NetworkServiceProtocol) {
        self.imageURLString = imageURLString
        self.networkService = networkService
    }
    
    // MARK: - Published Properties
    
    enum ImageState {
        case empty
        case loading
        case success(Image)
        case error(Error)
    }
    
    // MARK: Public Methods
    
    func loadImage() async {
        imageState = .loading
        
        do {
            let imageData = try await networkService.fetchCountryFlag(from: imageURLString)
            if let uiImage = UIImage(data: imageData) {
                imageState = .success(Image(uiImage: uiImage))
            }
        } catch {
            logger.error("Loading image: \(error.localizedDescription)")
            imageState = .error(error)
        }
    }
}
