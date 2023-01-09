//
//  UserEditPageViewModel.swift
//  listing-users
//
//  Created by Bernard Musaj on 7.1.23.
//

import SwiftUI

class UserEditPageViewModel: ObservableObject {
    
    private let databaseService: DatabaseService
    
    @ObservedObject var user: UserCD
    
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    
    @Published var showPopUp: Bool = false
    @Published var popUpType: PopUpType = .info
    @Published var popUpTitle: String = "Are you sure?"
    
    init(user: UserCD, databseService: DatabaseService = CoreDataService.shared) {
        self.user = user
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        self.email = user.email ?? ""
        self.databaseService = databseService
    }
    
    func save() {
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        databaseService.updateUser()
    }
}
