# LongPressButton

[![CI](https://github.com/Tunous/LongPressButton/actions/workflows/main.yml/badge.svg)](https://github.com/Tunous/LongPressButton/actions/workflows/main.yml)

A SwiftUI button that initiates action on tap or long press.

## Usage

Create `LongPressButton` similar to how you would create a regular `Button` passing it a title and action to perform on long press. You can also optionally pass an action for regular tap.

```swift
LongPressButton("Tap or long press me") { 
    // Long pressed
} action: { 
    // Tapped
}
```

Additionally you can configure minimum long press duration, maximum finger travel distance or provide custom label.

```swift
LongPressButton(minimumDuration: 0.5, maximumDistance: 10) { 
    // Long pressed
} action: { 
    // Tapped
} label: {
    Image(systemName: "plus")
}
```


## Installation

### Swift Package Manager

Add the following to the dependencies array in your "Package.swift" file:

```swift
.package(url: "https://github.com/Tunous/LongPressButton.git", .upToNextMajor(from: "1.0.0"))
```

Or add [https://github.com/Tunous/LongPressButton.git](https://github.com/Tunous/LongPressButton.git), to the list of Swift packages for any project in Xcode.

## Credits

[Supporting Both Tap and Long Press on a Button in SwiftUI](https://steipete.com/posts/supporting-both-tap-and-longpress-on-button-in-swiftui/) by Peter Steinberger - Great article with few potential solution on how to create button with long press action. Unfortunately none of them worked correctly for my use case.
