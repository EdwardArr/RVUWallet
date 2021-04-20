//
//  CPTViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/15/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class CPTViewModel: ObservableObject {

//    @Published var date : Date().timeIntervalSince1970
    @Published var cpt: CPT
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init(cpt: CPT = CPT(id: "", code: "", description: "", rvu: 0.0)) {
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
    
    func addCPT(cpt: CPT) {
        do{
            let _ = try db.collection("cpts").addDocument(from: cpt)
        }
        catch{
            print(error)
        }
    }
    
    func updateCPT(_ cpt: CPT) {
      if let documentId = cpt.id {
        do {
          try db.collection("cpts").document(documentId).setData(from: cpt)
        }
        catch {
          print(error)
        }
      }
    }
    
    func updateOrAddCPT() { // (1)
        if let _ = cpt.id {
          self.updateCPT(self.cpt) // (2)
        }
        else {
            addCPT(cpt:cpt) // (3)
        }
      }
    
    func save(){
        updateOrAddCPT()
    }
    
    func fetchCPTFromProcedures(cptID: String){
  
        db.collection("cpts")
            .document(cptID)
            .getDocument { (querysnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if let querysnapshot = querysnapshot {
                        do {
                            try? self.cpt = querysnapshot.data(as: CPT.self)!
                            print("-------------")
                            print(self.cpt)
                        }
                        catch {
                            print(err)
                        }
                        //                            print("\(querysnapshot!.documentID) => \(String(describing: querysnapshot!.data()))")
                    }
                    
                }
            }
    }
    
    func transferCPT(cptIDs: [String]) -> CPT {
        for i in cptIDs{
            if i == cpt.id{
                fetchCPTFromProcedures(cptID: i)
                
            }
        }
        return self.cpt
    }
}
