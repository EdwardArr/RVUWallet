//
//  CPTsViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/16/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CPTsViewModel: ObservableObject {
    
    @Published var cpts = [CPT]()
    @Published var totalRVU = 0.0
    @Published var rvus = [Double]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
        self.unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
            print("Unsubscribed from cpts collection.")
        }
    }
    
//    func fetchFavorites(favoriteCPTIDs: [String]) {
//
//        self.db.collection("cpts").parent(
//
//    }
    
//    func fetchCPTsFromProcedures(cptID: String){
//        
//        print("Fetch CPTs function called!")
//        
//        
//            db.collection("cpts")
//                .document(cptID)
//                .getDocument { (querysnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        if let querysnapshot = querysnapshot {
//                            do {
//                                try? self.cpts.append(querysnapshot.data(as: CPT.self)!)
//                                print("-------------")
//                                print(self.cpts)
//                            }
//                            catch {
//                                print(err)
//                            }
//                            //                            print("\(querysnapshot!.documentID) => \(String(describing: querysnapshot!.data()))")
//                        }
//                        
//                    }
//                }
//    }
            
        
//        //        print("Finished fetching CPTs from Procedures")
//        DispatchQueue.main.asyncAfter(deadline: .now()+1){ [self] in
//            rvusFromCPTDoc()
//        }
//    }
    
//    func rvusFromCPTDoc() {
//        
//        for i in self.cpts {
//            rvus.append(i.rvu)
//        }
//        
//        self.totalRVU = rvus.reduce(0, +)
//    }
    
    
    func subscribe() {

        let date = Date() // current date or replace with a specific date
        let calendar = Calendar.current
        let startTime = calendar.startOfDay(for: date).timeIntervalSince1970
        let endTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)?.timeIntervalSince1970
//        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!.timeIntervalSince1970

        listenerRegistration = db.collection("cpts")
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
        
//        if procedures.filter{$0.active == true}.count != 0 {
//        NotificationCenter.default.post(name: Notification.Name("data fetched"), object: nil)
//        }
    }
}
