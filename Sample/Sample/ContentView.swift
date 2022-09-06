//
//  ContentView.swift
//  Sample
//
//  Created by Łukasz Rutkowski on 06/09/2022.
//

import SwiftUI
import LongPressButton

struct ContentView: View {

    @State private var tapCount = 0
    @State private var longPressCount = 0
    @State private var minimumDuration: TimeInterval = 0.5
    @State private var maximumDistance: CGFloat = 10

    var body: some View {
        VStack {
            configuration

            LongPressButton("Tap or long press me", minimumDuration: minimumDuration, maximumDistance: maximumDistance) {
                longPressCount += 1
            } action: {
                tapCount += 1
            }
            .buttonStyle(.bordered)
            .accessibilityIdentifier(.longPressButton)
        }
        .padding()
    }

    @ViewBuilder
    private var configuration: some View {
        Text("Taps: \(tapCount)")
            .accessibilityIdentifier(.tapCountLabel)
        Text("Long presses: \(longPressCount)")
            .accessibilityIdentifier(.longPressLabel)

        Text("Minimum duration: \(minimumDuration.formatted())s")
        Slider(value: $minimumDuration, in: 0...5) {
            Text("Minimum duration")
        }

        Text("Maximum distance: \(maximumDistance.formatted())")
        Slider(value: $maximumDistance, in: 0...500) {
            Text("Maximum distance")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
