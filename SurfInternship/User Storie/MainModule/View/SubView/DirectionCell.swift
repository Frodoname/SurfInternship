//
//  DirectionCell.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

final class DirectionCell: UICollectionViewCell {
        
    // MARK: - Public Methods
    #warning("убрать force unwrap!")
    func configure(with internship: Internship?) {
        name.text = internship?.direction.title
        backgroundColor = internship!.isSelected ? ColorScheme.black : ColorScheme.gray
        name.textColor = internship!.isSelected ? ColorScheme.white : ColorScheme.black
    }
    
    // MARK: - Constants
    
    static let cellId = "cellId"
    private let cellCornerRadius: CGFloat = 12
    
    // MARK: - UI Elements
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = FontScheme.regular
        label.textColor = ColorScheme.black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        cellSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriding
    
//    override var isSelected: Bool {
//        didSet {
//            backgroundColor = isSelected ? ColorScheme.black : ColorScheme.gray
//            name.textColor = isSelected ? ColorScheme.white : ColorScheme.black
//        }
//    }
    
    // MARK: - Setup
    
    private func cellSetup() {
        backgroundColor = ColorScheme.gray
        layer.cornerRadius = cellCornerRadius
        
        layoutSetup()
    }
    
    private func layoutSetup() {
        [name].forEach {
            contentView.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
