//
//  UsersViewModel.swift
//  listing-users
//
//  Created by Bernard Musaj on 6.1.23.
//

import Foundation

struct UsersViewModel {
    
    private let databaseService: DatabaseService
    
    init(_ databaseService: DatabaseService = CoreDataService.shared) {
        self.databaseService = databaseService
    }
    
    func deleteUserWith(_ id: Int) {
        databaseService.deleteUser(id: Int(id))
    }
}
