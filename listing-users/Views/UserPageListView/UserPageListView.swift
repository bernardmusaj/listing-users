//
//  UserPageList.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI
import Combine

struct UserPageListView: View {
    
    private var viewModel: UsersViewModel = UsersViewModel()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \UserCD.firstName, ascending: true)], animation: .default)
    var users: FetchedResults<UserCD>
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(destination: UserEditPage(viewModel: UserEditPageViewModel(user: user))) {
                    UserRow(user: user)
                }.frame(height: 80)
            }.onDelete(perform: removeUser)
        }.navigationTitle("Users")
    }

    func removeUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            viewModel.deleteUserWith(Int(user.id))
        }
    }
}

struct UserPageList_Previews: PreviewProvider {
    static var previews: some View {
        UserPageListView()
    }
}


