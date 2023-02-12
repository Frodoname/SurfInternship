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
    
    private enum Height {
        static let collectionView: CGFloat = 44
    }
    
    private enum Padding {
        static let vertical: CGFloat = 24
        static let horizontal: CGFloat = 20
        static let down: CGFloat = 408
    }
    
    private enum StackSpacing {
        static let small: CGFloat = 12
        static let big: CGFloat = 24
    }
    
    private enum EdgeInset {
        static let top: CGFloat = 0
        static let left: CGFloat = 20
        static let right: CGFloat = 0
        static let bottom: CGFloat = 0
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
    
    private lazy var mainLabelWrapperView: WrapperView = WrapperView(view: mainLabel)
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontScheme.regular
        label.textColor = ColorScheme.fontGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = TextScheme.descriptionLabel
        return label
    }()
        
    private lazy var descriptionLabelWrapperView: WrapperView = WrapperView(view: descriptionLabel)
    
    lazy var upperCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DirectionCell.self, forCellWithReuseIdentifier: DirectionCell.cellId)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: EdgeInset.top, left: EdgeInset.left,
                                                   bottom: EdgeInset.bottom, right: EdgeInset.right)
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
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainLabelWrapperView, descriptionLabelWrapperView, upperCollectionView])
        stack.axis = .vertical
        stack.spacing = StackSpacing.small
        stack.setCustomSpacing(StackSpacing.big, after: upperCollectionView)
        return stack
    }()
    
    // MARK: - Init
    
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
        [upperCollectionView].forEach {
            $0.prepareForAutoLayOut()
        }
        
        [vStack].forEach {
            addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        NSLayoutConstraint.activate([
            upperCollectionView.heightAnchor.constraint(equalToConstant: Height.collectionView),
            
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: Padding.vertical),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.down)
        ])
    }
}
