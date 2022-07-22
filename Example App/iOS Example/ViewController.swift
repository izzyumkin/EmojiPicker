//
//  ViewController.swift
//  EmojiPicker
//
//  Created by Егор Бадмаев on 19.07.2022.
//

import UIKit
import EmojiPicker

class ViewController: UIViewController {
    
    private lazy var emojiButton: UIButton = {
        let button = UIButton()
        button.setTitle("😃", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        button.addTarget(self, action: #selector(openEmojiPickerModule), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @objc private func openEmojiPickerModule(sender: UIButton) {
        let configuration = EmojiPicker.Configuration(sourceViewController: self, sender: sender)
        EmojiPicker.present(with: configuration)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(emojiButton)
        
        NSLayoutConstraint.activate([
            emojiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            emojiButton.heightAnchor.constraint(equalToConstant: 80),
            emojiButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}

// MARK: - EmojiPickerDelegate
extension ViewController: EmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        emojiButton.setTitle(emoji, for: .normal)
    }
}
