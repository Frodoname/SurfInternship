//
//  InternshipDirection.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import Foundation

enum Internship {
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
    static let directionsOfInternship: [Internship] = [.ios, .android, .flutter, .design, .qa, .pm]
}
