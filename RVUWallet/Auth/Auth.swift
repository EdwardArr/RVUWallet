//
//  Auth.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/29/21.
//

import SwiftUI
import FirebaseAuth
import CryptoKit
import AuthenticationServices
import LocalAuthentication

// This typeAlias is defined just to make it simpler to deal with the tuble used in the SignInWithApple handle function once signed in.
typealias SignInWithAppleResult = (authDataResult: AuthDataResult, appleIDCredential: ASAuthorizationAppleIDCredential)

struct FBAuth {
    // Mark: - Sign In With Apple Functions
    static func signInWithApple(idTokenString: String, nonce: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        // Sign in with Apple.
        Auth.auth().signIn(with: credential) { (authDataResult, err) in
            if let err = err {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(err.localizedDescription)
                completion(.failure(err))
                return
            }
            // User is signed in to Firebase with Apple.
            guard let authDataResult = authDataResult else {
//                completion(.failure(SignInWithAppleAuthError.noAuthDataResult))
                return
            }
            completion(.success(authDataResult))
        }
    }
    
    static func handle(_ signInWithAppleResult: SignInWithAppleResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        // SignInWithAppleResult is a tuple with the authDataResult and appleIDCredentioal
        // Now that you are signed in, we can update our User database to add this user.
        
        // First the uid
        let uid = signInWithAppleResult.authDataResult.user.uid
        
        // Now Extract the fullname into a single string name
        // Note, you only get this object when the account is created.
        // All subsequent times, the fullName will be nill so you need to capture it now if you want it for
        // your database
        
        var name = ""
        let fullName = signInWithAppleResult.appleIDCredential.fullName
        // Extract all three components
        let givenName = fullName?.givenName ?? ""
        let middleName = fullName?.middleName ?? ""
        let familyName = fullName?.familyName ?? ""
        let names = [givenName, middleName, familyName]
        // remove any names that are empty
        let filteredNames = names.filter {$0 != ""}
        // Join the names together into a single name
        for i in 0..<filteredNames.count {
            name += filteredNames[i]
            if i != filteredNames.count - 1 {
                name += " "
            }
        }
        
        let email = signInWithAppleResult.authDataResult.user.email ?? ""
        
    }
    
    static func getBioMetricStatus(email:String, password:String)->Bool{
        
        let scanner = LAContext()
        if email != "" && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            return true
        }else{
            return false
        }
    }
}
