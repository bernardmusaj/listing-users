//
//  PopUpButton.swift
//  listing-users
//
//  Created by Bernard Musaj on 7.1.23.
//

import SwiftUI

struct PopUpButton: View {
    var type: PopUpType
    var title: String
    var action: (() -> Void)?
    
    var body: some View {
        Button(title, action: action ?? {})
            .frame(maxWidth: .infinity)
            .padding()
            .background(type == .error ? .black : .white)
            .foregroundColor(type == .error ? .white : .black)
            .cornerRadius(4)
    }
}
