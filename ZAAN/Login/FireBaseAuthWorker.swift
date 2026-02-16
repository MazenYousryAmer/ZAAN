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
}
