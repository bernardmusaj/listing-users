//
//  MainView.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Button("Get Users") {
                        viewModel.getUsers()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    NavigationLink("", destination: UserPageListView(), tag:1, selection: $viewModel.selection)
                }
            }
        }.overlay {
            PopUpView(show: $viewModel.showPopUp,
                      type: $viewModel.popUpType,
                      title: $viewModel.popUpTitle,
                      leftButton: "Close",
                      leftAction: closePopUp)
        }
    }
    
    func closePopUp() {
        viewModel.showPopUp = false
        viewModel.selection = 1
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
