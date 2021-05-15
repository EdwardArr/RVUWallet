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
    
    @Published var cpt: CPT
    
    @Published var cpts = [CPT]()
    
    @Published var id = ""
    
    @Published var errorMessage = ""
    
    init(user : User = User(id: "", email: "", first_name:"",last_name:"",revenue_per_rvu:"", favorite_cpts:[]), cpt: CPT = CPT(id: "", code: "", description: "", rvu: 0.0)){
        
        self.user = user
        self.cpt = cpt
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
    
    // Anything to do with users/cpts subcollection
    
    private var listenerRegistration: ListenerRegistration?
    
    func fetchCPTs(documentId: String) {
        
        listenerRegistration = db.collection("users").document(documentId).collection("cpts")
//            .whereField("first_name", isEqualTo: "Mike")
//            .whereField("start_epoch_timestamp", isLessThanOrEqualTo: endTime!)
            .addSnapshotListener { (QuerySnapshot, Error) in
                guard let documents = QuerySnapshot?.documents else {
                    print("No documents in the cpts collection")
                    return
                }
                
                self.cpts = documents.compactMap { (QuerySnapshot) -> CPT? in
//                     self.fetchedOn = Date().timeIntervalSince1970
                    return try? QuerySnapshot.data(as: CPT.self)
                }
//                Home.carsByHour(arrival: self.arrivals)
                print("\(self.cpts.count) cpts were found.")
                print("Subscribed to cpts collection.")
            }
    }
    
    func addCPTForUser(user: User) {
        do{
            let _ = try db.collection("users").document(user.id ?? "").collection("cpts").addDocument(from: cpt)
        }
        catch{
            print(error)
        }
    }
    
    func updateUserCPT(_ user: User, cpt: CPT) {
      if let documentId = user.id {
        do {
            print("Updated user: \(user.first_name)")
            try db.collection("users").document(documentId).collection("cpts").document(cpt.id ?? "").setData(from: cpt)
        }
        catch {
          print(error)
        }
      }
    }
    
    func updateOrAddUserCPT() { // (1)
        if let _ = user.id {
            
            self.updateUserCPT(self.user,cpt: self.cpt ) // (2)
        }
        else {
            addCPTForUser(user:user) // (3)
        }
    }
    
    func saveCPT(){
        updateOrAddUserCPT()
    }
    
    func deleteUserCPT(_  user: User, cpt: CPT) {
        if let documentId = user.id {
            db.collection("users").document(documentId).collection("cpts").document(cpt.id ?? "").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
}


