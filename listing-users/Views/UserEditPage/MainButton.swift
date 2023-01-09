//
//  MainButton.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

struct MainButton: View {
    
    enum ButtonType: String {
        case cancel
        case save
    }
    
    let type: ButtonType
    var action: (() -> Void)?
    
    var body: some View {
        Button(type.rawValue.capitalized) {
            action?()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(type == .save ? Color.blue : Color.gray.opacity(0.7))
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}
