//
//  WrapperView.swift
//  SurfInternship
//
//  Created by Fed on 09.02.2023.
//

import UIKit

final class WrapperView: UIView {
    
    var view: UIView
    
    // MARK: - Local Constants
    
    private let padding: CGFloat = 20
    
    // MARK: - Initi
    
    init(view: UIView) {
        self.view = view
        super.init(frame: .zero)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func initSetup() {
        [view].forEach {
            addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
