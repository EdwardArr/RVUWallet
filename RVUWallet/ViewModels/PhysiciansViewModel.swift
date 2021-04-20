//
//  PhysiciansViewModel.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/16/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class PhysiciansViewModel: ObservableObject {
    
    @Published var physicians = [Physician]()
//    @Published var fetchedOn = Double()
//    @Published var primary_md:String = ""
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
        self.unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
            print("Unsubscribed from physicians collection.")
        }
    }
    
//    func fetchFavorites(favoriteCPTIDs: [String]) {
//        
//        self.db.collection("cpts").parent(
//        
//    }
    
    func subscribe() {

        let date = Date() // current date or replace with a specific date
        let calendar = Calendar.current
        let startTime = calendar.startOfDay(for: date).timeIntervalSince1970
        let endTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)?.timeIntervalSince1970
//        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!.timeIntervalSince1970

        
        listenerRegistration = db.collection("physicians")
            .whereField("first_name", isEqualTo: "Michael")
//            .whereField("start_epoch_timestamp", isLessThanOrEqualTo: endTime!)
            .addSnapshotListener { (QuerySnapshot, Error) in
                guard let documents = QuerySnapshot?.documents else {
                    print("No documents in the physicians collection")
                    return
                }
                
                self.physicians = documents.compactMap { (QuerySnapshot) -> Physician? in
                    return try? QuerySnapshot.data(as: Physician.self)
                }
//                Home.carsByHour(arrival: self.arrivals)
                print("\(self.physicians.count) physicians were found.")
                print("Subscribed to physicians collection.")
            }
        
//        if procedures.filter{$0.active == true}.count != 0 {
//        NotificationCenter.default.post(name: Notification.Name("data fetched"), object: nil)
//        }
    }
}
