// The MIT License (MIT)
// Copyright © 2022 Ivan Izyumkin
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

extension UIColor {
    /// Color for EmojiPicker background - .systemGroupedBackground
    static let popoverBackgroundColor = UIColor(
        light:  UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0),
        dark: UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.0)
    )
    
    /// Color for selectedBackgroundView background in EmojiCollectionViewCell - .opaqueSeparator
    static let selectedCellBackgroundViewColor = UIColor(
        light: UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0),
        dark: UIColor(red: 0.28, green: 0.28, blue: 0.29, alpha: 1.0)
    )
    
    /// Color for selectedBackgroundView background in EmojiCollectionViewCell - .systemGray3
    static let separatorColor = UIColor(
        light: UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0),
        dark: UIColor(red: 0.22, green: 0.22, blue: 0.23, alpha: 1.0)
    )
    
    /// Increases brightness or decreases saturation
    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}

extension UIColor {
    /// Support for dark and light color versions
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, *) {
            self.init(dynamicProvider: { trait in
                trait.userInterfaceStyle == .dark ? dark : light
            })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}
