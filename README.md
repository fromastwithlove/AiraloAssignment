# Airalo Technical Interview Assignment – Local eSIMs iOS App

This iOS app is developed as part of the **Airalo technical interview assignment**. The project demonstrates the ability to build a Swift-based application that interacts with a remote eSIM API, displays country-specific eSIM packages, and follows modern development best practices using SwiftUI and MVVM.

---

## 🚀 Features

- [x] Fetches countries and their respective eSIM packages from the provided Local eSIMs API.
- [x] Displays country images, names, and available eSIM plans with package details.
- [x] Pixel-perfect UI following Figma designs.
- [x] Supports dynamic theming (light/dark) for operator card styles.
- [x] Fully responsive layout for iPhones and iPads.
- [x] Built using **MVVM architecture** for clean code separation.
- [x] Manages loading, success, and error UI states.

---

## 🛠 Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Networking**: URLSession with decodable models
- **Minimum Deployment Target**: iOS 17.0
- **Design Tool**: Figma (handoff provided)

---

## ✅ Project Implementation

### 1. Project Setup
- [x] Created and configured Xcode project in Swift with iOS 17+ support.
- [x] Repository hosted on GitHub: [https://github.com/fromastwithlove/AiraloAssignment](https://github.com/fromastwithlove/AiraloAssignment)
- **NOTE:** The repository is now public. All local assets originally provided by Airalo have been removed or replaced with open-source alternatives.

> ⚠️ **Disclaimer**  
> This project uses the backend API provided by [Airalo](https://www.airalo.com/), which is publicly accessible.  
> The API and its data are the intellectual property of Airalo and are used here strictly for demonstration purposes as part of a technical assignment.  
> All rights to the API and its content remain with Airalo.  
> © 2024 Airalo. All rights reserved.

### 2. API Integration
- [x] Integrated with the provided Local eSIMs API using Postman reference.
- [x] Implemented `NetworkService` to handle all API requests and response parsing.
- [x] Successfully fetched and decoded the country list and corresponding eSIM packages.
- [x] Investigating why requests weren't localizable.

### 3. UI Development
- [x] UI fully built using **SwiftUI**, programmatically.
- [x] Country and package displays follow exact Figma specs.
- [x] Handles various screen sizes with responsive spacing.

### 4. MVVM Architecture
- [x] View: Responsible only for UI rendering.
- [x] ViewModel: Handles API communication and state logic.
- [x] Model: Represents API response data.

### 5. State Management
- [x] Loading indicators, success state rendering, and error fallback views.
- [x] All state transitions are smoothly animated where appropriate.

### 6. Testing & QA
- [x] App runs on iPhones and iPads of all sizes.
- [x] Manual QA completed — design and functionality confirmed.
- [x] No Xcode warnings or build errors present.
- [x] Unit tests implemented, covering the network layer and API integration to ensure proper data fetching and response handling.
- [x] Documentation generated for the project and appended to the repository for future reference.
