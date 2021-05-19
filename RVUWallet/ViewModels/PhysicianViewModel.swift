//
//  PhysicianViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/16/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class PhysicianViewModel: ObservableObject {

//    @Published var date : Date().timeIntervalSince1970
    @Published var physician: Physician
    @Published var cpt: CPT
    
    @Published var errorMessage = ""
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init(physician: Physician = Physician(id: "dTsn2jWAdrtAMj4N1zYn", first_name: "Michael", last_name: "Blaney", phone_number: "+1(706)285-3186", email: "mike.blaney@bcofa.com", revenue_per_rvu: 54.19, favorite_cpts: [], procedures: []), cpt: CPT = CPT(id: "", code: "", description: "", rvu: 0.0)) {
        
        self.physician = physician
        self.cpt = cpt
    }
    
    deinit {
        self.unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
//    func fetchPhysician(documentId: String) {
//        let docRef = db.collection("physicians").document(documentId)
//        
//        docRef.getDocument { document, error in
//            if let error = error as NSError? {
//                self.errorMessage = "Error getting document: \(error.localizedDescription)"
//            }
//            else {
//                if let document = document {
//                    do {
//                        self.physician = try document.data(as: Physician.self)
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//    }
    
    func addPhysician(physician: Physician) {
        do{
            let _ = try db.collection("physicians").addDocument(from: physician)
        }
        catch{
            print(error)
        }
    }
    
    func fetchFavoriteCPTS(physician: Physician) {
        if let documentId = physician.id {
            do {
                try
                    db.collection("physicians").document(documentId)
                    .getDocument{
                (document, error) in
                        if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }
    }
    
    func addCPTForPhysician(physician: Physician) {
        do{
            let _ = try db.collection("physicians").document(physician.id ?? "").collection("cpts").addDocument(from: cpt)
        }
        catch{
            print(error)
        }
    }
    
    func updateProceduresList(physician: Physician, procedure:String) {
        if let documentId = physician.id {
            do {
                try
                    db.collection("users").document(documentId)
                    .updateData(["procedures": FieldValue.arrayUnion([procedure])
                    ])
            }
        }
    }
    
    func updateFavoriteCPTsList(physician: Physician, cpt:String) {
        if let documentId = physician.id {
            do {
                try
                    db.collection("physicians").document(documentId)
                    .updateData(["favorite_cpts": FieldValue.arrayUnion([cpt])
                    ])
            }
        }
    }
    
    func updatePhysician(_ physician: Physician) {
      if let documentId = physician.id {
        do {
          try db.collection("physicians").document(documentId).setData(from: physician)
        }
        catch {
          print(error)
        }
      }
    }
    
    func updateOrAddPhysician() { // (1)
        if let _ = physician.id {
          self.updatePhysician(self.physician) // (2)
        }
        else {
            addPhysician(physician:physician) // (3)
        }
      }
    
    func save(){
        updateOrAddPhysician()
    }
}
