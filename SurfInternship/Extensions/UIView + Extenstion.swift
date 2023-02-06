//
//  UIView + Extenstion.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

extension UIView {
    @discardableResult
    func prepareForAutoLayOut() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
