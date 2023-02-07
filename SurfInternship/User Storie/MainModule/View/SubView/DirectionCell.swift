//
//  DirectionCell.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

final class DirectionCell: UICollectionViewCell {
    
    static let cellId = "cellId"
    
    // MARK: - Public Methods
    
    func configure(with direction: Internship?) {
        name.text = direction?.title
    }
    
    // MARK: - Local Constants
    
    private let cellCornerRadius: CGFloat = 12
            
    // MARK: - UI Elements
    
    private lazy var name: UILabel = {
        $0.font = FontScheme.regular
        $0.textColor = ColorScheme.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        cellSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriding 
    
    override var isSelected: Bool {
            didSet {
                backgroundColor = isSelected ? ColorScheme.black : ColorScheme.gray
                name.textColor = isSelected ? ColorScheme.white : ColorScheme.black
            }
        }
    
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
