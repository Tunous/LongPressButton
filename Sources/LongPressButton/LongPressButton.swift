import SwiftUI

/// A control that initiates action on tap or long press.
public struct LongPressButton<Label: View>: View {
    private let minimumDuration: TimeInterval
    private let maximumDistance: CGFloat
    private let longPressAction: () -> Void
    private let action: () -> Void
    private let label: Label
    private let longPressActionName: Text?

    @available(iOS, obsoleted: 26.0)
    @State private var didLongPress = false
    @available(iOS, obsoleted: 26.0)
    @State private var longPressTask: Task<Void, Never>?

    public var body: some View {
        button
            .accessibilityAction {
                action()
            }
            .accessibilityAction(named: longPressActionName ?? Text("Alternative Action")) {
                longPressAction()
            }
    }

    @ViewBuilder
    private var button: some View {
        if #available(iOS 26.0, *) {
            Button(action: {}) {
                label
            }
            .simultaneousGesture(longPress.exclusively(before: tap))
        } else {
            Button(action: performActionIfNeeded) {
                label
            }
            .onLongPressGesture(
                maximumDistance: maximumDistance,
                perform: {},
                onPressingChanged: handleLongPress(isPressing:)
            )
        }
    }

    private var longPress: some Gesture {
        LongPressGesture(minimumDuration: minimumDuration, maximumDistance: maximumDistance)
            .onEnded { _ in
                longPressAction()
            }
    }

    private var tap: some Gesture {
        TapGesture().onEnded {
            action()
        }
    }

    @available(iOS, obsoleted: 26.0)
    private func performActionIfNeeded() {
        longPressTask?.cancel()
        if didLongPress {
            didLongPress = false
        } else {
            action()
        }
    }

    @available(iOS, obsoleted: 26.0)
    private func handleLongPress(isPressing: Bool) {
        longPressTask?.cancel()
        guard isPressing else { return }
        didLongPress = false
        longPressTask = Task {
            do {
                try await Task.sleep(nanoseconds: UInt64(minimumDuration * 1_000_000_000))
            } catch {
                return
            }
            didLongPress = true
            longPressAction()
        }
    }
}

// MARK: - Initialization

extension LongPressButton {

    /// Creates a long press button that displays a custom label.
    ///
    /// - Parameters:
    ///   - minimumDuration: The minimum duration of the long press that must elapse before the gesture succeeds.
    ///   - maximumDistance: The maximum distance that the fingers or cursor performing the long press can move before
    ///     the gesture fails.
    ///   - action: The action to perform when the user taps the button.
    ///   - longPressAction: The action to perform when the user long presses the button.
    ///   - longPressActionName: The name used by assistive technologies (such as VoiceOver) for the long-press accessibility action.
    ///   - label: A view that describes the purpose of the button’s action.
    public init(
        minimumDuration: TimeInterval = 0.5,
        maximumDistance: CGFloat = 10,
        longPressActionName: Text? = nil,
        action: @escaping () -> Void,
        longPressAction: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.minimumDuration = minimumDuration
        self.maximumDistance = maximumDistance
        self.action = action
        self.longPressAction = longPressAction
        self.longPressActionName = longPressActionName
        self.label = label()
    }

    /// Creates a long press button that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button’s localized title, that describes the purpose of the button’s action.
    ///   - minimumDuration: The minimum duration of the long press that must elapse before the gesture succeeds.
    ///   - maximumDistance: The maximum distance that the fingers or cursor performing the long press can move before
    ///     the gesture fails.
    ///   - longPressActionName: The name used by assistive technologies (such as VoiceOver) for the long-press accessibility action.
    ///   - action: The action to perform when the user taps the button.
    ///   - longPressAction: The action to perform when the user long presses the button.
    public init(
        _ titleKey: LocalizedStringKey,
        minimumDuration: TimeInterval = 0.5,
        maximumDistance: CGFloat = 10,
        longPressActionName: LocalizedStringKey? = nil,
        action: @escaping () -> Void,
        longPressAction: @escaping () -> Void
    ) where Label == Text {
        self.init(
            minimumDuration: minimumDuration,
            maximumDistance: maximumDistance,
            longPressActionName: longPressActionName.map { Text($0) },
            action: action,
            longPressAction: longPressAction
        ) {
            Text(titleKey)
        }
    }

    /// Creates a long press button that generates its label from a string.
    ///
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button’s action.
    ///   - minimumDuration: The minimum duration of the long press that must elapse before the gesture succeeds.
    ///   - maximumDistance: The maximum distance that the fingers or cursor performing the long press can move before
    ///     the gesture fails.
    ///   - longPressActionName: The name used by assistive technologies (such as VoiceOver) for the long-press accessibility action.
    ///   - action: The action to perform when the user taps the button.
    ///   - longPressAction: The action to perform when the user long presses the button.
    public init<S: StringProtocol>(
        _ title: S,
        minimumDuration: TimeInterval = 0.5,
        maximumDistance: CGFloat = 10,
        longPressActionName: S? = nil,
        action: @escaping () -> Void,
        longPressAction: @escaping () -> Void
    ) where Label == Text {
        self.init(
            minimumDuration: minimumDuration,
            maximumDistance: maximumDistance,
            longPressActionName: longPressActionName.map { Text($0) },
            action: action,
            longPressAction: longPressAction
        ) {
            Text(title)
        }
    }
}
