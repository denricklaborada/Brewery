# Brewery
Brewery is a clean and simple iOS app that shows a list of beers fetched from a public online API called [Punk API](https://punkapi.com/documentation/v2). This app also features a search functionality where you can look for a particular beer depending on your query. This was created using Swift and Storyboards.

# Installation
In the project's root folder, enter the following command:
```
pod install
```

# Third-Party Libraries Used
This project uses CocoaPods for its third-party libraries.

- Unrealm - This library is used for data persistence in case the user goes offline.
- Moya - This is used for the network calls needed to fetch data from the online API.
- SwiftGen - This generates Swift code for the resources of the project to make them type-safe.
- SwiftLint - This is used to enforce standard Swift coding conventions.
- Kingfisher - This is used for caching and downloading images from the web.
- Reusable - This makes for easier and cleaner code when loading Nibs.
- SnapKit - This is used for the programmatic layout of UI components.
- NVActivityIndicatorView - This is for the loading indicator displayed when fetching data.
