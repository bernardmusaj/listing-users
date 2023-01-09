//
//  PopUpType.swift
//  listing-users
//
//  Created by Bernard Musaj on 7.1.23.
//

import SwiftUI

enum PopUpType {
    case info
    case warning
    case success
    case error
    
    var icon: String {
        switch self {
        case .info, .warning: return "info"
        case .success: return "checkmark.circle"
        case .error: return "x.circle"
        }
    }
    
    var bgColor: Color {
        switch self {
        case .info: return .cyan
        case .warning: return .yellow
        case .success: return .green
        case .error: return .red
        }
    }
}
