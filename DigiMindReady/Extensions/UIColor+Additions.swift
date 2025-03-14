//
//  UIColor+Additions.swift
//  UIColor+Additions
//
//  Created by Md. Mehedi Hasan on 6/7/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import UIKit
import SwiftUI

extension UIColor {
    
    convenience init(redInt: Int, greenInt: Int, blueInt: Int, alpha: CGFloat = 1.0) {
        self.init(
            displayP3Red: CGFloat(redInt) / 255.0,
            green: CGFloat(greenInt) / 255.0,
            blue: CGFloat(blueInt) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            redInt: (hex >> 16) & 0xFF,
            greenInt: (hex >> 8) & 0xFF,
            blueInt: hex & 0xFF,
            alpha: alpha
        )
    }
    
    convenience init?(hexRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexRGB.hasPrefix("#") ? hexRGB.dropFirst() : hexRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }
    
    /// The SwiftUI color associated with the receiver.
    var suColor: Color { Color(self) }
}

/// MissingHashMarkAsPrefix:   "Invalid RGB string, missing '#' as prefix"
/// UnableToScanHexValue:      "Scan hex error"
/// MismatchedHexStringLength: "Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8"
enum UIColorInputError: Error {
  case missingHashMarkAsPrefix
  case unableToScanHexValue
  case mismatchedHexStringLength
  case outputHexStringForWideDisplayColor
}

extension UIColor {
  /// The shorthand three-digit hexadecimal representation of color.
  /// #RGB defines to the color #RRGGBB.
  ///
  /// - parameter hex3: Three-digit hexadecimal value.
  /// - parameter alpha: 0.0 - 1.0. The default is 1.0.
  convenience init(hex3: UInt16, alpha: CGFloat = 1) {
    let divisor = CGFloat(15)
    let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
    let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
    let blue = CGFloat( hex3 & 0x00F) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// The shorthand four-digit hexadecimal representation of color with alpha.
  /// #RGBA defines to the color #RRGGBBAA.
  ///
  /// - parameter hex4: Four-digit hexadecimal value.
  convenience init(hex4: UInt16) {
    let divisor = CGFloat(15)
    let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
    let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
    let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
    let alpha = CGFloat( hex4 & 0x000F       ) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// The six-digit hexadecimal representation of color of the form #RRGGBB.
  ///
  /// - parameter hex6: Six-digit hexadecimal value.
  convenience init(hex6: UInt32, alpha: CGFloat = 1) {
    let divisor = CGFloat(255)
    let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
    let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
    let blue = CGFloat( hex6 & 0x0000FF       ) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
  ///
  /// - parameter hex8: Eight-digit hexadecimal value.
  convenience init(hex8: UInt32) {
    let divisor = CGFloat(255)
    let red = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
    let green = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
    let blue = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
    let alpha = CGFloat( hex8 & 0x000000FF       ) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
  ///
  /// - parameter rgba: String value.
  convenience init(rgbaThrows rgba: String) throws {
    guard rgba.hasPrefix("#") else {
      throw UIColorInputError.missingHashMarkAsPrefix
    }

    let hexString = String(rgba[String.Index(utf16Offset: 1, in: rgba)...])
    var hexValue: UInt32 = 0

    guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
      throw UIColorInputError.unableToScanHexValue
    }

    switch hexString.count {
    case 3:
      self.init(hex3: UInt16(hexValue))
    case 4:
      self.init(hex4: UInt16(hexValue))
    case 6:
      self.init(hex6: hexValue)
    case 8:
      self.init(hex8: hexValue)
    default:
      throw UIColorInputError.mismatchedHexStringLength
    }
  }

  /// The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
  ///
  /// - parameter rgba: String value.
  convenience init(_ rgba: String, defaultColor: UIColor = UIColor.clear) {
    guard let color = try? UIColor(rgbaThrows: rgba) else {
      self.init(cgColor: defaultColor.cgColor)
      return
    }

    self.init(cgColor: color.cgColor)
  }

  /// Hex string of a UIColor instance, throws error.
  ///
  /// - parameter includeAlpha: Whether the alpha should be included.
  func hexStringThrows(_ includeAlpha: Bool = true) throws -> String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    guard red >= 0 && red <= 1 && green >= 0 && green <= 1 && blue >= 0 && blue <= 1 else {
      throw UIColorInputError.outputHexStringForWideDisplayColor
    }

    if includeAlpha {
      return String(format: "#%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
    } else {
      return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
  }

  /// Hex string of a UIColor instance, fails to empty string.
  ///
  /// - parameter includeAlpha: Whether the alpha should be included.
  func hexString(_ includeAlpha: Bool = true) -> String {
    guard let hexString = try? hexStringThrows(includeAlpha) else {
      return ""
    }

    return hexString
  }
}
