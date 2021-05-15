//
//  ProcedureViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/15/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class ProcedureViewModel: ObservableObject {

//    @Published var date : Date().timeIntervalSince1970
    @Published var procedure: Procedure
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init(procedure: Procedure = Procedure(cpt_id: "", cpt_code: "", cpt_description:"", cpt_rvu: 0.0, hospital_barcode: "", primary_md:"dTsn2jWAdrtAMj4N1zYn", procedure_date:0.0, date:"")) {
        self.procedure = procedure
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
    
    func addProcedure(procedure: Procedure) {
        do{
            let _ = try db.collection("procedures").addDocument(from: procedure)
        }
        catch{
            print(error)
        }
    }
    
    func updateProcedure(_ procedure: Procedure) {
      if let documentId = procedure.id {
        do {
          try db.collection("procedures").document(documentId).setData(from: procedure)
        }
        catch {
          print(error)
        }
      }
    }
    
    func updateOrAddIncident() { // (1)
        if let _ = procedure.id {
          self.updateProcedure(self.procedure) // (2)
        }
        else {
            addProcedure(procedure:procedure) // (3)
        }
      }
    
    func save(){
        updateOrAddIncident()
    }
    
    func deleteProcedure(_ procedure: Procedure) {
        if let _ = procedure.id {
            db.collection("procedures").document(procedure.id ?? "").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
}
