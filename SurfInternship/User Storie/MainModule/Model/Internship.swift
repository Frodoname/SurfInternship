//
//  InternshipDirection.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import Foundation

struct Internship {
    let direction: Direction
    var isSelected: Bool
}

enum Direction {
    case ios
    case android
    case flutter
    case design
    case qa
    case pm
    
    var title: String {
        switch self {
        case .ios:
            return "IOS"
        case .android:
            return "Android"
        case .flutter:
            return "Flutter"
        case .design:
            return "Design"
        case .qa:
            return "QA"
        case .pm:
            return "PM"
        }
    }
}

extension Internship {
    static let directionsOfInternship: [Internship] = [Internship(direction: .ios, isSelected: false),
                                                       Internship(direction: .android, isSelected: false),
                                                       Internship(direction: .flutter, isSelected: false),
                                                       Internship(direction: .design, isSelected: false),
                                                        Internship(direction: .qa, isSelected: false),
                                                        Internship(direction: .pm, isSelected: false)]
}

