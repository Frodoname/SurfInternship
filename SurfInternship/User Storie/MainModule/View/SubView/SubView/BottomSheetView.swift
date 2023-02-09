//
//  ButtonSheetView.swift
//  SurfInternship
//
//  Created by Fed on 09.02.2023.
//

import UIKit

final class BottomSheetView: UIView {
    
    // MARK: - Local Constants
    
    private let cornerRadius: CGFloat = 32
    
    private enum Padding {
        static let vertical: CGFloat = 24
        static let horizontal: CGFloat = 20
        static let down: CGFloat = 408
    }
    
    private enum StackSpacing {
        static let small: CGFloat = 12
        static let big: CGFloat = 24
    }
    
    // MARK: - UI Elements
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = FontScheme.bold
        label.textAlignment = .left
        label.textColor = ColorScheme.black
        label.text = TextScheme.mainLabel
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontScheme.regular
        label.textColor = ColorScheme.fontGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = TextScheme.descriptionLabel
        return label
    }()
    
    private lazy var mainLabelWrapperView: WrapperView = WrapperView(view: mainLabel)
    
    private lazy var descriptionLabelWrapperView: WrapperView = WrapperView(view: descriptionLabel)
    
    lazy var upperCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DirectionCell.self, forCellWithReuseIdentifier: DirectionCell.cellId)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextScheme.secondDescription
        label.numberOfLines = 0
        label.font = FontScheme.regular
        label.textColor = ColorScheme.fontGray
        return label
    }()
    
    private lazy var secondDescriptionLabelWrapperView: WrapperView = WrapperView(view: secondDescriptionLabel)
    
    lazy var downCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DirectionCell.self, forCellWithReuseIdentifier: DirectionCell.cellId)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainLabelWrapperView, descriptionLabelWrapperView, upperCollectionView, secondDescriptionLabelWrapperView, downCollectionView])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = StackSpacing.small
        stack.setCustomSpacing(StackSpacing.big, after: upperCollectionView)
        return stack
    }()
    
    //    private lazy var vStack: UIStackView = {
    //        let vStack = UIStackView(arrangedSubviews: [])
    //        vStack.axis = .vertical
    //        vStack.distribution = .fillEqually //было .proportionally, заработало после equally
    //        vStack.spacing = stackSpacing
    //        return vStack
    //    }()
    
    // MARK: - Initi
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func initSetup() {
        backgroundColor = ColorScheme.white
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        layoutSetup()
    }
    
    private func layoutSetup() {
        [vStack].forEach {
            addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: Padding.vertical),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.down)
        ])
    }
}
