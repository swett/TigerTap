//
//  SFWConfiguration.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)

private let cyanColor = UIColor.cyan
private let circleStrokeWidth: CGFloat = 10
private let _position: SFWConfiguration.Position = .top

extension SFWConfiguration {
    static var blackCyanColorsConfiguration: SFWConfiguration {
        
        var imageAnchor = SFWConfiguration.AnchorImage(imageName: "arrow",
                                                                     size: CGSize(width: 43, height: 40),
                                                                     verticalOffset: 0)
        
        imageAnchor.tintColor = .clear
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                   strokeColor: .clear)
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .clear, oddColor: .clear)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                          strokeWidth: 1,
                                                                          strokeColor: UIColor(hexString: "#FF4004"))
    
        var wheelPreference = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: _position)
        
        wheelPreference.imageAnchor = imageAnchor
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 43, height: 40),
                                                                                 position: _position,
                                                                                 verticalOffset: -25)
      
        
        var spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 43, height: 61))
    
        spinButtonPreferences.textColor = UIColor(hexString: "#FF4004")
        spinButtonPreferences.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        spinButtonPreferences.backgroundColor = .clear

        let configuration = SFWConfiguration(wheelPreferences: wheelPreference,
                                             pinPreferences: pinPreferences,
                                             spinButtonPreferences: spinButtonPreferences)
        
        return configuration
    }
}

extension ImagePreferences {
    static var prizeImagePreferences: ImagePreferences {
        let preferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25),
                                           verticalOffset: 10)
        return preferences
    }
}

extension TextPreferences {
    static var amountTextWithWhiteBlackColorsPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: .white)
        let font = UIFont.systemFont(ofSize: 23, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
    
    static var descriptionTextWithWhiteBlackColorsPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: .white)
        let font = UIFont.systemFont(ofSize: 23, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
    
    
    static var amountTextWithBlackColorPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .clear)
        let font = UIFont.systemFont(ofSize: 23, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
    
    static var descriptionTextWithBlackColorPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .clear)
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
}


extension LinePreferences {
    static var defaultPreferences: LinePreferences {
        let colorType = SFWConfiguration.ColorType.customPatternColors(colors: [.orange, .purple, .yellow, .blue, .brown, .green, .systemPink, .systemTeal, .brown, .green, .white, .black, .magenta], defaultColor: .red)
        let preferences = LinePreferences(colorType: colorType, height: 2, verticalOffset: 10)
        return preferences
    }
}
