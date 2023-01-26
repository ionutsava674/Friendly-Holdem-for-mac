//
//  midOpacityTransfer.swift
//  Friendly Holdem for mac
//
//  Created by Ionut Sava on 26.01.2023.
//

import SwiftUI

extension AnyTransition {
    static var midOpacityTransfer: AnyTransition {
        .asymmetric(
        insertion: .modifier(
            active: OpModifier( opaque: 0.0),
            identity: OpModifier( opaque: 1.0)),
        removal: .modifier(
            active: OpModifier( opaque: 0.0),
            identity: OpModifier( opaque: 1.0)))
    } //cv
} //ext
