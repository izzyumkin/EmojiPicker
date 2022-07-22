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

/// Delegate for event handling in `EmojiPickerView`
protocol EmojiPickerViewDelegate: AnyObject {
    /**
     Processes an event by category selection.
     - Parameter index: index of the selected category.
     */
    func didChoiceEmojiCategory(at index: Int)
}

final class EmojiPickerView: UIView {
    
    // MARK: - Private properties
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separatorColor
        return view
    }()
    
    private let categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .popoverBackgroundColor
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var categoryViews = [TouchableEmojiCategoryView]()
    
    /// Describes height for `categoriesStackView`
    private var categoriesStackViewHeight: CGFloat {
        // The number 0.13 was taken based on the proportion of this element to the width of the EmojiPicker on MacOS.
        return bounds.width * 0.13
    }
    
    // MARK: - Public properties
    public let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.verticalScrollIndicatorInsets.top = 8
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.identifier)
        collectionView.register(EmojiCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmojiCollectionViewHeader.identifier)
        return collectionView
    }()
    
    public weak var delegate: EmojiPickerViewDelegate?
    
    public var selectedEmojiCategoryTintColor: UIColor = .systemBlue
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupCategoryViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupView()
    }
    
    /**
     Passes the index of the selected category to all categoryViews to update the state.
     - Parameter categoryIndex: Selected category index.
     */
    public func updateSelectedCategoryIcon(with categoryIndex: Int) {
        categoryViews.forEach({
            $0.updateCategoryViewState(selectedCategoryIndex: categoryIndex)
        })
    }
    
    // MARK: - Private methods
    private func setupView() {
        backgroundColor = .popoverBackgroundColor
        
        addSubview(collectionView)
        addSubview(categoriesStackView)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top),
            collectionView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            
            categoriesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoriesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoriesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsets.bottom),
            categoriesStackView.heightAnchor.constraint(equalToConstant: categoriesStackViewHeight),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: categoriesStackView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupCategoryViews() {
        for categoryIndex in 0...7 {
            let categoryView = TouchableEmojiCategoryView(
                delegate: self,
                categoryIndex: categoryIndex,
                selectedEmojiCategoryTintColor: selectedEmojiCategoryTintColor
            )
            // Installing selected state for first categoryView
            categoryView.updateCategoryViewState(selectedCategoryIndex: 0)
            categoryViews.append(categoryView)
            categoriesStackView.addArrangedSubview(categoryView)
        }
    }
    
    /**
     Scroll collectionView to header for selected category.
     - Parameter section: Selected category index.
     */
    private func scrollToHeader(for section: Int) {
        guard let cellFrame = collectionView.collectionViewLayout.layoutAttributesForItem(at: IndexPath(item: 0, section: section))?.frame,
              let headerFrame = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: section))?.frame
        else { return }
        collectionView.setContentOffset(CGPoint(x:  -collectionView.contentInset.left, y: cellFrame.minY - headerFrame.height), animated: false)
    }
}

// MARK: - EmojiCategoryViewDelegate
extension EmojiPickerView: EmojiCategoryViewDelegate {
    func didChoiceCategory(at index: Int) {
        scrollToHeader(for: index)
        delegate?.didChoiceEmojiCategory(at: index)
    }
}
