//
//  AuthViewModel.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class AuthViewModel {
    
    
    func signUp(username: String, email: String, password: String) async throws {
        let userReference = Firestore.firestore().collection("Users")
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await userReference.document(result.user.uid).setData(["username": username, "email": email])
    }
    
    func signIn(email: String, Password: String) async throws {
        
        try await Auth.auth().signIn(withEmail: email, password: Password)
        
    }
    
    func logOut() async throws {
        
        try Auth.auth().signOut()
        
    }
    
}
