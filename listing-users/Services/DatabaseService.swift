//
//  DatabaseService.swift
//  listing-users
//
//  Created by Bernard Musaj on 5.1.23.
//

import CoreData

protocol DatabaseService: AnyObject {
    func insert(users: [UserData])
    func deleteUser(id: Int)
    func updateUser()
}

public final class CoreDataService {
    
    static let shared = CoreDataService()
    private var container: NSPersistentContainer
    private let persistentName = "listing_users"
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: persistentName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self.container.viewContext.automaticallyMergesChangesFromParent = true
        })
    }
}

// MARK: DatabaseService
extension CoreDataService: DatabaseService {
    
    func deleteUser(id: Int) {
        deleteUserWith(id: id)
    }

    func updateUser() {
        save()
    }
     
    func insert(users: [UserData]) {
        for user in users {
            if !userExist(user.id) {
                insert(user)
            }
        }
    }
    
    private func insert(_ user: UserData) {
        let newUser = UserCD(context: context)
        newUser.id = Int16(user.id)
        newUser.firstName = user.first_name
        newUser.lastName = user.last_name
        newUser.email = user.email
        newUser.avatar = user.avatar
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func userExist(_ id: Int) -> Bool {
        let user = getUserWith(id: id)
        return user != nil
    }
    
    private func getUserWith(id: Int) -> UserCD? {
        do {
            let fetchedUsers = try context.fetch(requestUserBy(id: id))
            return fetchedUsers.count > 0 ? fetchedUsers.first : nil
        } catch {
            print("Failed to request User with ID: \(id)")
            return nil
        }
    }
    
    private func requestUserBy(id: Int) -> NSFetchRequest<UserCD> {
        let fetchRequest = UserCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        return fetchRequest
    }
    
    @discardableResult
    private func deleteUserWith(id: Int) -> Bool {
        guard let user = getUserWith(id: id) else { return false }
        context.delete(user)
        return save()
    }
    
    @discardableResult
    private func save() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print("Could not save to Core Date, Error: \(error.localizedDescription)")
            return false
        }
    }
}
