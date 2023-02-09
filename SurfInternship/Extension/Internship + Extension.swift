//
//  Internship + Extension.swift
//  SurfInternship
//
//  Created by Fed on 08.02.2023.
//

import Foundation

extension Internship: Equatable {
    static func == (lhs: Internship, rhs: Internship) -> Bool {
        if (lhs.isSelected == rhs.isSelected) && (lhs.direction == rhs.direction) {
            return true
        } else {
            return false
        }
    }
}
