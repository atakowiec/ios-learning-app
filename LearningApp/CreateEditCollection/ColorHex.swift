//
//  ColorHex.swift
//  LearningApp
//
//  Created by student on 7/6/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255
            let b = Double(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(.white)
        }
    }
    
    func toHexString() -> String {
        let components = UIColor(self).cgColor.components
        let r = components?[0] ?? 0
        let g = components?[1] ?? 0
        let b = components?[2] ?? 0
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
    var isWhite: Bool {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else { return false }
        return components[0] > 0.95 && components[1] > 0.95 && components[2] > 0.95
    }
    
    // Funkcja pomocnicza do zwrócenia czarnego koloru, jeśli jest biały
    func adjustedIfWhite() -> Color {
        return self.isWhite ? .black : self
    }
}
