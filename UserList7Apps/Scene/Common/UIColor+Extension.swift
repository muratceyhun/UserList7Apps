//
//  UIColor+Extension.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import UIKit

extension UIColor {
    public convenience init(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if pureString.hasPrefix("#") {
            pureString.remove(at: pureString.startIndex)
        }
        guard pureString.count == 6 else {
            self.init(white: 1.0, alpha: CGFloat(alpha))
            return
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha)
            )
        } else {
            self.init(white: 1.0, alpha: CGFloat(alpha))
        }
    }
}

extension UIColor {
    static let primaryRedColor = UIColor(hex: "#D2233C")
    static let primaryBlueColor = UIColor(hex: "#3240DC")
    static let softBlueColor = UIColor(hex: "#3495EB")
    static let softWhiteColor = UIColor(hex: "F5F5F5")
}
