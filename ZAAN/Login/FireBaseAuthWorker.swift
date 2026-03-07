//
//  Untitled.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 24/11/2025.
//

import Foundation
import FirebaseAuth

class FireBaseAuthWorker {
    
    func login(name: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: name, password: password) {authResult, error  in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                completion(Result.failure(error))
                
            } else {
                print("User signed in: \(authResult?.user.email ?? "N/A")")
                completion(Result.success(authResult!))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle specific errors, e.g., weak password, email already in use
                print("Error creating user: \(error.localizedDescription)")
                completion(Result.failure(error))
            }
            // User registered successfully!
            if let user = authResult?.user {
                print("User registered: \(user.email ?? "N/A")")
                completion(Result.success(authResult!))
                // Now you can access the user object and perform further actions
                // such as storing additional user data in Cloud Firestore or Firebase Data Connect.
            }
        }
    }
}
