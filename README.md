# EmojiPicker
Emoji picker for iOS like on macOS

<p float="left">
<img src="https://user-images.githubusercontent.com/50948518/172110164-b0dec76f-495d-4112-ad00-2708ffdda54a.gif" width="230">
<img src="https://user-images.githubusercontent.com/50948518/171909950-ebf388f3-83a1-4b63-ad54-f58ba947e3bb.png" width="230">
</p>

## Installation
Ready for use with Swift 4.2+ on iOS 11.1+

### Swift Package Manager
The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.
```swift
dependencies: [
    .package(url: "https://github.com/htmlprogrammist/EmojiPicker", .upToNextMajor(from: "1.0.3"))
]
```

### Manually
If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/EmojiPicker` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Quick Start
Create `UIButton` and add selector as action:
```swift
@objc private func openEmojiPickerModule(sender: UIButton) {
    let configuration = EmojiPicker.Configuration(sourceViewController: self, sender: sender)
    EmojiPicker.present(with: configuration)
}
```

And then recieve emoji in the delegate method:
```swift
extension ViewController: EmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        emojiButton.setTitle(emoji, for: .normal)
    }
}
```

## Usage
### Required parameters
`sourceViewController` is the view controller on which EmojiPicker is being presenter. 

`sender` is the view containing the anchor rectangle for the popover. You can create any `UIView` instances and set them as the `sender`

Also, there is way more settings for configuration:

### Selected emoji category tint color
Color for the selected emoji category. The default value of this property is `.systemBlue`.

```swift
configuration.selectedEmojiCategoryTintColor = .systemRed
```

### Arrow direction
The direction of the arrow for EmojiPicker. The default value of this property is `.up`

```swift
configuration.arrowDirection = .up,
```

### Horizontal inset
Inset from the `sourceView` border. The default value of this property is `0`

```swift
configuration.horizontalInset = 0
```

### Is dismiss after choosing
Defines whether to dismiss emoji picker or not after choosing. The default value of this property is `true`

```swift
configuration.isDismissAfterChoosing = true
```

### Custom height
Custom height for EmojiPicker. The default value of this property is `nil`

```swift
configuration.customHeight = 300
```

### Feedback generator style
Feedback generator style. To turn off, set `nil` to this parameter. The default value of this property is `.light`.

```swift
configuration.feedBackGeneratorStyle = .soft
```

## To do
- [x] The main functionality for choosing emojis
- [x] Dark mode
- [x] Segmented control for jumping an emoji section
- [x] Automatic adjustment of the relevant set of emoji for the iOS version
- [ ] Select skin tones from popup
- [ ] Seach bar and search results
- [ ] Recently used

## Localizations
* English 🇬🇧
* Russian 🇷🇺
