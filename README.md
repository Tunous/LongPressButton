# LongPressButton

[![CI](https://github.com/Tunous/LongPressButton/actions/workflows/main.yml/badge.svg)](https://github.com/Tunous/LongPressButton/actions/workflows/main.yml)

A SwiftUI button that initiates action on tap or long press.

## Usage

Create `LongPressButton` similar to how you would create a regular `Button` passing it a title, action to perform on tap and an action to perform on long press.

```swift
LongPressButton("Tap or long press me") { 
    // Tapped
} longPressAction: { 
    // Long pressed
}
```

Additionally you can configure minimum long press duration, maximum finger travel distance or provide custom label.

```swift
LongPressButton(minimumDuration: 0.5, maximumDistance: 10) { 
    // Tapped
} longPressAction: { 
    // Long pressed
} label: {
    Image(systemName: "plus")
}
```

## Installation

### Swift Package Manager

Add the following to the dependencies array in your "Package.swift" file:

```swift
.package(url: "https://github.com/Tunous/LongPressButton.git", .upToNextMajor(from: "1.1.0"))
```

Or add [https://github.com/Tunous/LongPressButton.git](https://github.com/Tunous/LongPressButton.git), to the list of Swift packages for any project in Xcode.

## Credits

[Supporting Both Tap and Long Press on a Button in SwiftUI](https://steipete.me/posts/2021/supporting-both-tap-and-longpress-on-button-in-swiftui) by Peter Steinberger - Great article with few potential solution on how to create button with long press action. Unfortunately none of them worked correctly for my use case.
