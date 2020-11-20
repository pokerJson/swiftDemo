//
//  EPColor.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/16.
//

import UIKit

// MARK: 通过16进制初始化UIColor
extension UIColor {
    
    convenience init?(hexNum: Int) {
        self.init(hexStr: String(hexNum, radix: 16))
    }
    
    convenience init?(hexStr: String) {
        var hex = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        if hex.hasPrefix("0x") || hex.hasPrefix(("0X")) {
            hex.removeSubrange((hex.startIndex ..< hex.index(hex.startIndex, offsetBy: 2)))
        }
        
        guard let hexNum = Int(hex, radix: 16) else {
            self.init()
            return nil
        }
        switch hex.count {
        case 3:
            self.init(red: CGFloat(((hexNum & 0xF00) >> 8).duplicate4bits) / 255.0,
                      green: CGFloat(((hexNum & 0x0F0) >> 4).duplicate4bits) / 255.0,
                      blue: CGFloat((hexNum & 0x00F).duplicate4bits) / 255.0,
                      alpha: 1.0)
        case 4:
            self.init(red: CGFloat(((hexNum & 0xF000) >> 12).duplicate4bits) / 255.0,
                      green: CGFloat(((hexNum & 0x0F00) >> 8).duplicate4bits) / 255.0,
                      blue: CGFloat(((hexNum & 0x00F0) >> 4).duplicate4bits) / 255.0,
                      alpha: CGFloat((hexNum & 0x000F).duplicate4bits) / 255.0)
        case 6:
            self.init(red: CGFloat((hexNum & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((hexNum & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat((hexNum & 0x0000FF) >> 0) / 255.0,
                      alpha: 1.0)
        case 8:
            self.init(red: CGFloat((hexNum & 0xFF000000) >> 24) / 255.0,
                      green: CGFloat((hexNum & 0x00FF0000) >> 16) / 255.0,
                      blue: CGFloat((hexNum & 0x0000FF00) >> 8) / 255.0,
                      alpha: CGFloat(hexNum & 0x000000FF) / 255.0)
        default:
            self.init()
            return nil
        }
    }
    
}

private extension Int {
    var duplicate4bits: Int {
        return self << 4 + self
    }
}
