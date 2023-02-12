//
//  ApplyButtonView.swift
//  SurfInternship
//
//  Created by Fed on 09.02.2023.
//

import UIKit

final class ApplyButtonView: UIView {
    
    // MARK: - Local Constants
    
    private let spacingValue: CGFloat = 24
    private let cornerRadius: CGFloat = 32
    
    private enum ButtonSize {
        static let width: CGFloat = 219
        static let height: CGFloat = 60
    }
    
    private enum Padding {
        static let horizontal: CGFloat = 20
        static let vertical: CGFloat = 58
    }
    
    // MARK: - UI Elements
    
    private lazy var buttonDescriptor: UILabel = {
        let label = UILabel()
        label.text = TextScheme.buttonDescriptor
        label.textColor = ColorScheme.fontGray
        label.font = FontScheme.regular
        label.numberOfLines = 0
        return label
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextScheme.buttonTitle, for: .normal)
        button.setTitleColor(ColorScheme.white, for: .normal)
        button.backgroundColor = ColorScheme.black
        button.layer.cornerRadius = cornerRadius
        button.prepareForAutoLayOut()
        button.heightAnchor.constraint(equalToConstant: ButtonSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: ButtonSize.width).isActive = true
        return button
    }()
    
    private lazy var hStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [buttonDescriptor, applyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = spacingValue
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        viewSetup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func viewSetup() {
        backgroundColor = ColorScheme.white
        layoutSetup()
    }
    
    private func layoutSetup() {
        [hStack].forEach {
            addSubview($0)
            $0.prepareForAutoLayOut()
            
            NSLayoutConstraint.activate([
                hStack.topAnchor.constraint(equalTo: topAnchor),
                hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.horizontal),
                hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Padding.horizontal),
                hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.vertical)
            ])
        }
    }
}
