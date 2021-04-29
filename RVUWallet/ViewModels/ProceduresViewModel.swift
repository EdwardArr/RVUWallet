//
//  ProceduresViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/15/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProceduresViewModel: ObservableObject {
    
    @Published var procedures = [Procedure]()
    @Published var fetchedOn = Double()
    @Published var performedCPTS = [String]()
    @Published var primary_md:String = ""
    
    @Published var cpts = [CPT]()
    @Published var totalRVU = 0.0
    @Published var rvus = [Double]()
    
//    var user_id:String = ""
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
//    deinit {
//        self.unsubscribe()
//    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
            print("Unsubscribed from Procedures collection.")
        }else{
            print("Unsubscribed function called when Today collection is already unsubscribed.")
        }
    }
    
    func cptIDFromProcedureDoc() {
        
        self.performedCPTS = []

        for i in self.procedures {
            performedCPTS.append(i.cpt_id)
        }
    }
    
    func rvusFromCPTDoc() {
        
        self.rvus = []
        
        for i in self.procedures {
            rvus.append(i.cpt_rvu)
        }
        self.totalRVU = rvus.reduce(0, +)
    }

    
    func subscribe(user_id:String) {

        let startOfMonth = Date().startOfMonth.timeIntervalSince1970
        let endOfMonth = Date().endOfMonth.timeIntervalSince1970

        listenerRegistration = db.collection("procedures")
            .whereField("primary_md", isEqualTo: user_id)
            .whereField("procedure_date", isGreaterThanOrEqualTo: startOfMonth)
            .whereField("procedure_date", isLessThanOrEqualTo: endOfMonth)
            .addSnapshotListener { [self] (QuerySnapshot, Error) in
                guard let documents = QuerySnapshot?.documents else {
                    print("No documents in the procedure collection")
                    return
                }
                
                self.procedures = documents.compactMap { (QuerySnapshot) -> Procedure? in
                    self.fetchedOn = Date().timeIntervalSince1970
                    return try? QuerySnapshot.data(as: Procedure.self)
                }
                print("\(self.procedures.count) procedures were found.")
                print("Subscribed to procedures collection.")
                
                rvusFromCPTDoc()
                
//                DispatchQueue.main.asyncAfter(deadline:.now()+1){
//                    self.cptIDFromProcedureDoc()
//                }
                
//                DispatchQueue.main.asyncAfter(deadline:.now()+1){
//                    self.fetchCPTsFromProcedures()
//                }

//                self.fetchCPTsFromProcedures() {success in
//                    if success{
//                        print("moving on to rvusFromCPTDoc function")
//                        rvusFromCPTDoc()
//                    }else{
//
//                    }
//                }
            }
        
//        if procedures.filter{$0.active == true}.count != 0 {
//        NotificationCenter.default.post(name: Notification.Name("data fetched"), object: nil)
//        }
    }
    
    func fetchCPTsFromProcedures() {
        
        self.cpts = []
        
        for i in self.performedCPTS {
            
            self.db.collection("cpts")
                .document(i)
                .getDocument { (querysnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let querysnapshot = querysnapshot {
                            do {
                                try? self.cpts.append(querysnapshot.data(as: CPT.self)!)
                                print("-------------")
                                print(self.cpts)
                            }
                            catch {
                                print(err)
                            }
                            //                            print("\(querysnapshot!.documentID) => \(String(describing: querysnapshot!.data()))")
                        }
                        
                    }
                    
                }
            //                }
//            let flag = true
//            print("Function called fetchCPTsFromProcedures was completed")
//            completionHandler(flag)
//            DispatchQueue.main.asyncAfter(deadline:.now()+1){
                self.rvusFromCPTDoc()
//            }
        }
    }
}
