//
//  MainViewModel.swift
//  listing-users
//
//  Created by Bernard Musaj on 6.1.23.
//

import Combine

class MainViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var selection: Int? = nil
    @Published var showPopUp: Bool = false
    @Published var popUpType: PopUpType = .info
    @Published var popUpTitle: String = ""
    
    private let databaseService: DatabaseService
    private let networkService: NetworkService
    
    init(_ databaseService: DatabaseService = CoreDataService.shared, _ networkService: NetworkService = APIService()) {
        self.databaseService = databaseService
        self.networkService = networkService
    }
    
    func getUsers() {
        networkService.getUsers().sink {[weak self] result in
            switch result {
            case .failure(_):
                self?.showPopUp = true
                self?.popUpType = .error
                self?.popUpTitle = "Network Error"
                print("Error")
            case .finished:
                break
            }
        } receiveValue: {[weak self] userResponse in
            self?.insertUsersInDb(userResponse?.data ?? [])
            self?.showPopUp = true
            self?.popUpType = .success
            self?.popUpTitle = "Success"
        }.store(in: &cancellables)
    }
    
    private func insertUsersInDb(_ users: [UserData]) {
        self.databaseService.insert(users: users)
    }
}
