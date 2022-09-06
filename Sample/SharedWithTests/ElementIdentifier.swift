//
//  ElementIdentifier.swift
//  Sample
//
//  Created by Łukasz Rutkowski on 06/09/2022.
//

import Foundation
import SwiftUI

enum ElementIdentifier: String {
    case tapCountLabel
    case longPressLabel
    case longPressButton
}

extension View {
    func accessibilityIdentifier(_ elementIdentifier: ElementIdentifier) -> some View {
        self.accessibilityIdentifier(elementIdentifier.rawValue)
    }
}
