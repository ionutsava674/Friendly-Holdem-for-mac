//
//  Color_UIColor.swift
//  Friendly Holdem for mac
//
//  Created by Ionut Sava on 24.01.2023.
//

import SwiftUI

#if os(macOS)
    typealias NSUIColor = NSColor
typealias NSUIImage = NSImage
#elseif os(iOS)
    typealias NSUIColor = UIColor
typealias NSUIImage = UIImage
#endif

extension Color {
    static let systemBackground: Color = {
        #if os(iOS)
        Color( uiColor: .systemBackground)
        #elseif os(macOS)
        Color( nsColor: .windowBackgroundColor)
        #endif
    }() //sv
    static let secondarySystemBackground: Color = {
        #if os(iOS)
        Color( uiColor: .secondarySystemBackground)
        #elseif os(macOS)
        Color( nsColor: .unemphasizedSelectedContentBackgroundColor)
        #endif
    }() //sv
    static let tertiarySystemBackground: Color = {
        #if os(iOS)
        Color( UIColor.tertiarySystemBackground)
#elseif os(macOS)
        Color( nsColor: .selectedContentBackgroundColor)
        #endif
    }() //cv
    static let separatorColor: Color = {
        #if os(iOS)
        Color(UIColor.opaqueSeparator)
#elseif os(macOS)
        Color( nsColor: .separatorColor)
        #endif
    }() //cv

        func bright( amount: CGFloat) -> Self {
            #if os(iOS)
            let u: UIColor = UIColor(self)
            var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, o: CGFloat = 0
            guard u.getHue(&h, saturation: &s, brightness: &b, alpha: &o) else {
                return self
            } //gua
                let db = Swift.min(1.0, Swift.max(0.0, b * amount))
                return Color( hue: h, saturation: s, brightness: db, opacity: o)
            #elseif os(macOS)
            guard let u: NSColor = NSColor(self).usingColorSpace(.sRGB) else {
                return self
            } //gua
            var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, o: CGFloat = 0
            u.getHue(&h, saturation: &s, brightness: &b, alpha: &o)
                let db = Swift.min(1.0, Swift.max(0.0, b * amount))
                return Color( hue: h, saturation: s, brightness: db, opacity: o)
            #endif
        } //func
    func blendMed1( with secondColor: Color) -> Color {
#if os(iOS)
        let c1: UIColor = UIColor( self)
        //let cc = c1.cgColor.converted(to: CGColorSpace(, intent: .defaultIntent, options: nil)
        let c2: UIColor = UIColor( .black)
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        guard c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1),
              c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else {
            return self
        } //gua
        //return Color( UIColor( red: (r1 + r2) / 2, green: (g1 + g2) / 2, blue: (b1 + b2) / 2, alpha: (a1 + a2) / 2))
        //return Color( uiColor: UIColor( red: (r1 + r2) / 2, green: (g1 + g2) / 2, blue: (b1 + b2) / 2, alpha: (a1 + a2) / 2))
        return Color(RGBColorSpace.sRGB, red: (r1 + r2) / 2, green: (g1 + g2) / 2, blue: (b1 + b2) / 2, opacity: (a1 + a2) / 2)
        //return .systemBackground
#elseif os(macOS)
        guard let c1: NSUIColor = NSUIColor( self).usingColorSpace(.deviceRGB),
              let c2: NSUIColor = NSUIColor( secondColor).usingColorSpace(.deviceRGB) else {
            return self
        } //gua
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return Color( NSColor( red: (r1 + r2) / 2, green: (g1 + g2) / 2, blue: (b1 + b2) / 2, alpha: (a1 + a2) / 2))
#endif
    } //func

} //ext
#if os(iOS)
/*
extension UIColor {
    func blendMed(with secondColor: UIColor) -> UIColor {
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        guard getRed(&r1, green: &g1, blue: &b1, alpha: &a1),
              secondColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else {
            return self
        } //gua
        return UIColor( red: (r1 + r2) / 2, green: (g1 + g2) / 2, blue: (b1 + b2) / 2, alpha: (a1 + a2) / 2)
    } //func
} //ext
 */
#endif
