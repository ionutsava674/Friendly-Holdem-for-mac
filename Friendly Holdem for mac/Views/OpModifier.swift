//
//  OpModifier.swift
//  Friendly Holdem for mac
//
//  Created by Ionut Sava on 26.01.2023.
//

import SwiftUI

struct OpModifier: ViewModifier {
    let opaque: Double
    func body(content: Content) -> some View {
        content
            .opacity(opaque > 0.5 ? 1.0 : 0.0)
    } //body
} //modif str
