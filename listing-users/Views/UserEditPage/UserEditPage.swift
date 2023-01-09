//
//  UserEditPage.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

struct UserEditPage: View {
        
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: UserEditPageViewModel
    
    var body: some View {
            VStack {
                ImageView(withURL: viewModel.user.avatar!, 120)
                UserInputView(name: $viewModel.firstName, placeholder: "First Name")
                UserInputView(name: $viewModel.lastName, placeholder: "Last Name")
                UserInputView(name: $viewModel.email, placeholder: "Email").disabled(true)
                Spacer()
                HStack {
                    MainButton(type: .cancel) {
                        viewModel.showPopUp = true
                    }
                    
                    MainButton(type: .save) {
                        viewModel.save()
                        dismiss()
                    }
                }
            }
            .padding()
            .navigationTitle("Edit User")
            .overlay {
                PopUpView(show: $viewModel.showPopUp,
                          type: $viewModel.popUpType,
                          title: $viewModel.popUpTitle,
                          leftButton: "No",
                          rightButton: "Yes",
                          leftAction: { viewModel.showPopUp = false },
                          rightAction: dismiss)
            }
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
