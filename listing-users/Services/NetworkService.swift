//
//  NetworkService.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import Foundation
import Combine

public enum Constants {
    static let baseUrl = "https://reqres.in/api/"
    static let users = baseUrl + "users"
}

public protocol NetworkService {
    func getUsers() -> AnyPublisher<UsersResponse?, Error>
}

public class APIService: NetworkService {

    public func getUsers() -> AnyPublisher<UsersResponse?, Error> {

        return URLSession(configuration: .ephemeral).dataTaskPublisher(for: URL(string: Constants.users)!)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response in
                
                do {
                    let object = try JSONDecoder().decode(UsersResponse.self, from: data)
                    return object
                } catch let DecodingError.dataCorrupted(context) {
                    print("Decoding error: \(String(describing: context))")
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)")
                } catch {
                    print("Error decoding data")
                }
                
                return try JSONDecoder().decode(UsersResponse.self, from: data)
            }.mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
}

public struct UsersResponse: Decodable {
    public var page: Int
    public var total: Int
    public var data: [UserData]
}

public struct UserData: Decodable, Identifiable {
    public var id: Int
    public var email: String
    public var first_name: String
    public var last_name: String
    public var avatar: String
}
