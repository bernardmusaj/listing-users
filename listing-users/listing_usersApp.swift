//
//  listing_usersApp.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

@main
struct listing_usersApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView().environment(\.managedObjectContext, CoreDataService.shared.context)
//            UserPageList(users: [User(), User()])
//            UserEditPage(user: User())
//            ContentView()
//                .environment(\.managedObjectContext, CoreDataService.shared.context)
        }
    }
}
