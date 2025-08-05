//
//  DatabaseHelper.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 25/06/25.
//

import Foundation

struct DatabaseHelper {
 
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
      let (data, _) =  try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
        
    }
}
