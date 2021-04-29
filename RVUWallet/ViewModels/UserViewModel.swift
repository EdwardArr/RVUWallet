//
//  UserViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/23/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserViewModel: ObservableObject {
    
    enum AuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAutheticated: AuthState = .undefined
    
    @Published var user: User
    
    @Published var id = ""
    
    @Published var errorMessage = ""
    
    init(user : User = User(id: "", email: "", first_name:"",last_name:"",revenue_per_rvu:"", favorite_cpts:[])){
        
        self.user = user
    }
    
    private var db = Firestore.firestore()
    
    var authDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        authDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else{
                self.isUserAutheticated = .signedOut
                return
            }
            self.isUserAutheticated = .signedIn
        })
    }
    
    func fetchUser(documentId: String) {
        
        if documentId == nil || documentId == ""{
            return
        }else{
            let docRef = db.collection("users").document(documentId)
            
            docRef.addSnapshotListener { document, error in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                    if let document = document {
                        do {
                            self.user = try document.data(as: User.self) ?? User(email: "", first_name: "", last_name: "", revenue_per_rvu: "", favorite_cpts: [])
                            print("Fetching user:\(documentId)")
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func addUser(user: User) {
        do{
            let _ = try db.collection("users").addDocument(from: user)
        }
        catch{
            print(error)
        }
    }
    
    func updateUser(_ user: User) {
      if let documentId = user.id {
        do {
            print("Updated user: \(user.first_name)")
          try db.collection("users").document(documentId).setData(from: user)
        }
        catch {
          print(error)
        }
      }
    }
    
    func updateOrAddUser() { // (1)
        if let _ = user.id {
            
            self.updateUser(self.user ) // (2)
        }
        else {
            addUser(user:user) // (3)
        }
    }
    
    func save(){
        updateOrAddUser()
    }
    
    func signOut() {
        do {
          try Auth.auth().signOut()
            print("User signed out.")
        } catch {
          print("Sign out error")
        }
    }
    
}


