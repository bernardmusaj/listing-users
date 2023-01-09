//
//  PopUpWindow.swift
//  listing-users
//
//  Created by Bernard Musaj on 7.1.23.
//

import SwiftUI

struct PopUpView: View {
    @Binding var show: Bool
    @Binding var type: PopUpType
    @Binding var title: String
    
    var message: String = "Message for the alert to be shown in case of error, error, info or warning."
    var leftButton: String = "Cancel"
    var rightButton: String = "Ok"
    var leftAction: (() -> Void)?
    var rightAction: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if show {
                    Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                    
                    VStack (spacing: .zero) {
                        VStack {
                            iconView
                            titleView
                            contentView
                            buttonsView
                        }.padding()
                            .multilineTextAlignment(.center)
                            .background(type.bgColor)
                            .cornerRadius(8)
                    }.padding()
                }
            }
        }
        .animation(.easeIn(duration: 0.1))
    }
}

extension PopUpView {
    var iconView: some View {
        Image (systemName: type.icon)
            .symbolVariant(.circle.fill)
            .font (.system(size: 50, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
    }
    
    var titleView: some View {
        Text (title)
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding ()
    }
    
    var contentView: some View {
        Text(message).padding().font(.callout).foregroundColor(.white)
    }
    
    var buttonsView: some View {
        HStack {
            PopUpButton(type: .info, title: leftButton, action: leftAction)
            
            if rightAction != nil {
                PopUpButton(type: type, title: rightButton, action: rightAction)
            }
        }.padding()
    }
}
