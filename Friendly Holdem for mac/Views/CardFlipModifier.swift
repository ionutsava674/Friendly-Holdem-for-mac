//
//  CardFlipModifier.swift
//  Friendly Holdem for mac
//
//  Created by Ionut Sava on 26.01.2023.
//

import SwiftUI

struct CardFlipModifier: ViewModifier {
    let angleX: Angle
    let opaque: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect( angleX, axis: (x: 1.0, y: 0.0, z: 0.0))
            .opacity(opaque > 0.5 ? 1.0 : 0.0)
    } //body
} //modif str
