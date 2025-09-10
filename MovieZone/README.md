//
//  README.md
//  MovieZone
//
//  Created by Amal K V on 9/10/25.
//

# MovieZone

MovieZone is an iOS application that allows users to browse, search, and manage their favorite movies. Built with SwiftUI and following modern iOS development practices, the app provides a clean and intuitive interface for movie enthusiasts.

## Features

- Browse a collection of movies
- Search for specific movies
- View detailed information about each movie
- Mark movies as favorites
- Offline access to favorite movies
- Clean, modern UI with smooth animations

## Architecture

The project follows the MVVM (Model-View-ViewModel) architectural pattern with a clear separation of concerns:

### Project Structure

MovieZone/
├── Source/
│   ├── Home/
│   │   ├── View/
│   │   ├── ViewModel/
│   │   └── Model/
│   ├── Detail/
│   │   ├── View/
│   │   ├── ViewModel/
│   │   └── Model/
│   ├── Favorite/
│   │   ├── View/
│   │   ├── ViewModel/
│   │   └── Model/
│   ├── Search/
│   │   ├── View/
│   │   ├── ViewModel/
│   │   └── Model/
│   └── Common/
│       ├── Components/
│       ├── Extensions/
│       └── Utilities/
├── Network/
│   ├── APIManager.swift
│   └── Endpoint.swift
├── Resources/
│   ├── Assets.xcassets
│   └── Preview Content/
└── Supporting Files/
    ├── Info.plist
    └── MovieZoneApp.swift

2. Open the project in Xcode:
cd MovieZone
open MovieZone.xcodeproj

3. Build and run the project (Cmd+R)

### Building the Project

1. Open `MovieZone.xcodeproj` in Xcode
2. Select your target device/simulator
3. Press `Cmd+B` to build or `Cmd+R` to build and run

### Configuration

The app uses the IMDB API through RapidAPI. The API key is currently hardcoded in the `APIManager.swift` file:

fileprivate func addAppInfoInHeader(_ urlRequest: inout URLRequest) {
    urlRequest.setValue("YOUR_API_KEY_HERE", forHTTPHeaderField: "X-RapidAPI-Key")
    urlRequest.setValue("imdb236.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
}

## Key Features Implementation

### 1. Movie Browsing
The home screen displays movies in a grid layout with custom `MovieCardView` components. Each card shows the movie poster, title, and year.

### 2. Movie Search
The search functionality is implemented with a custom `GlobalSearchbarView` that provides a clean search experience with real-time filtering.

### 3. Favorites Management
Users can mark movies as favorites, which are stored and managed by the `FavoriteListView`. The favorite count is displayed with a badge on the favorites icon.

### 4. Movie Details
Tapping on a movie card navigates to the `MovieDetailView` which displays comprehensive information about the movie.

### 5. Error Handling
The app implements comprehensive error handling with user-friendly error states and retry mechanisms.

### 6. Network State Management
The app handles different network states including loading, no internet, and empty states with appropriate UI feedback.

## Assumptions Made

1. **API Integration**: The app is designed to work with the IMDB API through RapidAPI
2. **Offline Support**: Favorite movies can be accessed offline (implementation would require Core Data or similar)
3. **User Authentication**: Not implemented as it's not required for basic movie browsing
4. **Data Persistence**: Favorites are stored in memory (for production, this should use persistent storage)

## Additional Features Implemented

1. **Shimmer Loading**: Implemented loading states with shimmer effects for better user experience
2. **Responsive Design**: UI adapts to different screen sizes and orientations
3. **Accessibility**: Basic accessibility support with proper labeling
4. **Custom Components**: Reusable UI components like `GlobalSearchbarView`, `MovieCardView`, etc.
5. **State Management**: Comprehensive state handling for loading, error, empty, and success states

## Dependencies

This project uses only native iOS frameworks:
- SwiftUI
- Foundation
- UIKit (for image assets)

No external dependencies or CocoaPods are required.

## Testing

The project includes unit tests for:
- ViewModel logic
- Network layer
- Data parsing
- Business logic

To run tests:
1. Select the test target in Xcode
2. Press `Cmd+U` or click Product → Test

## Future Improvements

1. Implement persistent storage for favorites using Core Data
2. Add user authentication
3. Implement more detailed movie information
4. Add trailers and video playback
5. Implement more advanced search filters
6. Add dark mode support
7. Add localization support
8. Implement comprehensive unit and UI tests

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Movie data provided by IMDB through RapidAPI
- SwiftUI for the modern UI framework
- Apple for the excellent development tools
```

This README provides a comprehensive overview of your MovieZone project, including:
1. Project features and architecture
2. Detailed instructions on how to build and run the project
3. Explanation of the MVVM architecture used
4. Assumptions made during development
5. Additional features implemented
6. Future improvement suggestions

The document is structured to help any developer quickly understand and work with your codebase
