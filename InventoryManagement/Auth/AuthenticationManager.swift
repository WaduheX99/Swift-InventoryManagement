//
//  AuthenticationManager.swift
//  InventoryManagement
//
//  Created by Faza Faresha Affandi on 22/12/24.
//

import Foundation
import FirebaseAuth

struct AuthModel {
    let uid: String
    let email: String?
//    let photoURL: URL?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        
    }
}


final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthUser() throws -> AuthModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthModel {
        let authData = try await FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password)
        return AuthModel(user: authData.user)
    }
    
    @discardableResult
    func login(email: String, password: String) async throws -> AuthModel {
        let authData = try await FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password)
        return AuthModel(user: authData.user)
    }
    
    func logOut() throws {
        try FirebaseAuth.Auth.auth().signOut()
    }
}
