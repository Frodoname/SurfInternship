//
//  ApplyButtonView.swift
//  SurfInternship
//
//  Created by Fed on 09.02.2023.
//

import UIKit

final class ApplyButtonView: UIStackView {
    
    private let spacingValue: CGFloat = 24
    private let cornerRadius: CGFloat = 32
    
    private enum ButtonSize {
        static let width: CGFloat = 219
        static let height: CGFloat = 60
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
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutSetup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func layoutSetup() {
        spacing = spacingValue
        distribution = .fillProportionally
        axis = .horizontal
        addArrangedSubview(buttonDescriptor)
        addArrangedSubview(applyButton)
    }
}
