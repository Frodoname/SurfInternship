//
//  MainView.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

protocol ApplyButtonProtocol: AnyObject {
    func applyButtonTapped()
}

final class MainView: UIView {
    
    weak var delegate: ApplyButtonProtocol?
    
    // MARK: - Local Constants
    
    private let image = "backgroundImage"
    private let stackSpacing: CGFloat = 12
    
    private enum CornerRaduis: CGFloat {
        case bottomSheet = 32
        case applyButton = 52
    }
    
    private enum Padding: CGFloat {
        case vertical = 24
        case horizontal = 20
    }
    
    private enum Text: String {
        case mainLabel = "Стажировка в Surf"
        case descriptionLabel = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        case buttonTitle = "Отправить заявку"
        case buttonDescriptor = "Хочешь к нам?"
    }
    
    // MARK: - UI Elements
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        return imageView
    }()
    
    private lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorScheme.white
        view.clipsToBounds = true
        view.layer.cornerRadius = CornerRaduis.applyButton.rawValue
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = FontScheme.bold
        label.textAlignment = .left
        label.textColor = ColorScheme.black
        label.text = Text.mainLabel.rawValue
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontScheme.regular
        label.textColor = ColorScheme.fontGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = Text.descriptionLabel.rawValue
        return label
    }()
    
    lazy var upperCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ColorScheme.white
        collectionView.register(DirectionCell.self, forCellWithReuseIdentifier: DirectionCell.cellId)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [mainLabel, descriptionLabel, upperCollectionView])
        vStack.axis = .vertical
        vStack.distribution = .fillEqually //было .proportionally, заработало после equally
        vStack.spacing = stackSpacing
        return vStack
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var buttonDescriptor: UILabel = {
        let label = UILabel()
        label.text = Text.buttonDescriptor.rawValue
        label.textColor = ColorScheme.fontGray
        label.font = FontScheme.regular
        return label
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle(Text.buttonTitle.rawValue, for: .normal)
        button.setTitleColor(ColorScheme.white, for: .normal)
        button.backgroundColor = ColorScheme.black
        button.layer.cornerRadius = CornerRaduis.bottomSheet.rawValue
        button.prepareForAutoLayOut()
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 219).isActive = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [buttonDescriptor, applyButton])
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.spacing = 24
        return hStack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func viewSetup() {
        backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        
        layoutSetup()
    }
    
    private func layoutSetup() {
        [scrollView, hStack].forEach {
            addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        [contentView].forEach {
            scrollView.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        [backgroundImage, bottomSheetView].forEach {
            contentView.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        [vStack, /*upperCollectionView*/].forEach {
            bottomSheetView.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        #warning("убрать число в константы")
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bottomSheetView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -100),
            bottomSheetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            vStack.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: Padding.vertical.rawValue),
            vStack.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: Padding.horizontal.rawValue),
            vStack.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -Padding.horizontal.rawValue),
            vStack.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor), // эта строчка должна будет уехать
            
            //            upperCollectionView.topAnchor.constraint(equalTo: vStack.topAnchor, constant: 12),
            //            upperCollectionView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            //            upperCollectionView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            //            upperCollectionView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor, constant: 100) //-500
            
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -58)
        ])
    }
}

@objc
private
extension MainView {
    func didTapButton() {
        delegate?.applyButtonTapped()
    }
}
