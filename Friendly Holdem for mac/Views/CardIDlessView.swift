//
//  CardIDlessView.swift
//  Friendly Holdem for mac
//
//  Created by Ionut Sava on 26.01.2023.
//

import SwiftUI

struct CardIDlessView: View {
    @ObservedObject var card: Card
    let cardWidth: CGFloat
    private var cardHeight: CGFloat { cardWidth * RawCard.cardSizeRatio }
    let faceDown: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let backFacingText: String?

    var body: some View {
        ZStack {
            if faceDown {
            Image("blue", label: Text(backFacingText ?? "card facing down"))
                .resizable()
                .scaledToFit()
                .transition(.modifier(
                    active: CardFlipModifier(angleX: .degrees(-180), opaque: 0.0),
                    identity: CardFlipModifier(angleX: .zero, opaque: 1.0)))
                .accessibilityRemoveTraits(.isImage)
            }
            if !faceDown {
                Image(card.id, label: Text(card.readableName))
                .resizable()
                .scaledToFit()
                .transition(.modifier(
                    active: CardFlipModifier(angleX: .degrees(180), opaque: 0.0),
                    identity: CardFlipModifier(angleX: .zero, opaque: 1.0)))
                .accessibilityRemoveTraits(.isImage)
                .accessibilityValue(Text(card.readableName))
                .accessibilityLabel(Text(""))
            }
        } //zs
        .shadow( radius: 5)
        .frame(maxWidth: cardWidth, maxHeight: cardHeight, alignment: .center)
    } //body
} //str
