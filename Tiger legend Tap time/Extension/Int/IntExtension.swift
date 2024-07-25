//
//  IntExtension.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 19.07.2024.
//

import Foundation

extension Int {
    var formattedTo: String {
        if self >= 1_000_000 {
            let formatted = Double(self) / 1_000_000
            if formatted.truncatingRemainder(dividingBy: 1) == 0 {
                return "\(Int(formatted))m"
            } else {
                return "\(String(format: "%.1f", formatted))m"
            }
        } else if self >= 1_000 {
            let formatted = Double(self) / 1_000
            if formatted.truncatingRemainder(dividingBy: 1) == 0 {
                return "\(Int(formatted))k"
            } else {
                return "\(String(format: "%.1f", formatted))k"
            }
        } else {
            return "\(self)"
        }
    }
}
