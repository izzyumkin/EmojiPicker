// The MIT License (MIT)
// Copyright © 2022 Egor Badmaev
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

extension EmojiPicker {
    public struct Configuration {
        /// A view controller on which EmojiPicker is being presented
        public var sourceViewController: UIViewController
        /// The view containing the anchor rectangle for the popover
        public var sender: UIView
        /// Tint color for the selected emoji category
        public var selectedEmojiCategoryTintColor: UIColor?
        /// The direction of the arrow for EmojiPicker
        public var arrowDirection: PickerArrowDirectionMode
        /// Inset from the sourceView border
        public var horizontalInset: CGFloat
        /// Defines whether to dismiss emoji picker or not after choosing
        public var isDismissAfterChoosing: Bool
        /// Custom height for EmojiPicker
        public var customHeight: CGFloat?
        /// Feedback generator style. To turn off, set `nil` to this parameter
        public var feedBackGeneratorStyle: UIImpactFeedbackGenerator.FeedbackStyle? = .light
        
        public init(sourceViewController: UIViewController,
                    sender: UIView,
                    selectedEmojiCategoryTintColor: UIColor? = nil,
                    arrowDirection: PickerArrowDirectionMode = .up,
                    horizontalInset: CGFloat = 0,
                    isDismissAfterChoosing: Bool = true,
                    customHeight: CGFloat? = nil
        ) {
            self.sourceViewController = sourceViewController
            self.sender = sender
            self.selectedEmojiCategoryTintColor = selectedEmojiCategoryTintColor
            self.arrowDirection = arrowDirection
            self.horizontalInset = horizontalInset
            self.isDismissAfterChoosing = isDismissAfterChoosing
            self.customHeight = customHeight
        }
    }
}
