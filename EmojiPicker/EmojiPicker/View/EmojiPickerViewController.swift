//
//  EmojiPickerViewController.swift
//  EmojiPicker
//
//  Created by Иван Изюмкин on 01.06.2022.
//

import UIKit

protocol EmojiPickerDelegate: AnyObject {
    func didGetEmoji(emoji: String)
}

final class EmojiPickerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var delegate: EmojiPickerDelegate?
    
    // TODO: - Add customizing the top padding from sourceView
    
    // MARK: - Private Properties
    
    private let emojiPickerView = EmojiPickerView()
    private let generator = UIImpactFeedbackGenerator(style: .light)
    
    private var viewModel: EmojiPickerViewModelProtocol
    
    // MARK: - Initializers
    
    init(viewModel: EmojiPickerViewModelProtocol = EmojiPickerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupDelegates()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = emojiPickerView
    }
    
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.selectedEmoji.bind { [unowned self] emoji in
            generator.impactOccurred()
            delegate?.didGetEmoji(emoji: emoji)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupDelegates() {
        emojiPickerView.collectionView.delegate = self
        emojiPickerView.collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension EmojiPickerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojiCollectionViewCell.identifier,
            for: indexPath
        ) as? EmojiCollectionViewCell else { return UICollectionViewCell() }
        cell.emoji = viewModel.emoji(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: EmojiSectionHeader.identifier,
                for: indexPath
              ) as? EmojiSectionHeader else { return UICollectionReusableView() }
        sectionHeader.categoryName = viewModel.sectionHeaderViewModel(for: indexPath.section)
        return sectionHeader
    }
}

// MARK: - UICollectionViewDelegate

extension EmojiPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedEmoji.value = viewModel.emoji(at: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EmojiPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: 40
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let sideInsets = collectionView.contentInset.right + collectionView.contentInset.left
        let contentSize = collectionView.bounds.width - sideInsets
        return CGSize(
            width: contentSize / 8,
            height: contentSize / 8
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}
