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
    
    private enum Padding {
        static let bottomSheet: CGFloat = 100
        static let horizontalButton: CGFloat = 20
        static let verticalButton: CGFloat = 58
    }
    
    // MARK: - UI Elements
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        return imageView
    }()
    
    lazy var bottomSheetView: BottomSheetView = BottomSheetView()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var applyButtonView: ApplyButtonView = ApplyButtonView()
    
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
        applyButtonView.applyButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func layoutSetup() {
        [scrollView].forEach {
            addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        [contentView].forEach {
            scrollView.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        [backgroundImage, bottomSheetView, applyButtonView].forEach {
            contentView.addSubview($0)
            $0.prepareForAutoLayOut()
        }
    
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
            
            bottomSheetView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -Padding.bottomSheet),
            bottomSheetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            applyButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            applyButtonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            applyButtonView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
