//
//  Physician.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/16/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Physician: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var first_name: String
    var last_name: String
    var phone_number: String
    var email: String
    var revenue_per_rvu: Double
    var favorite_cpts: [String]
    var procedures: [String]

    
    init(id: String, first_name: String, last_name: String, phone_number: String, email: String, revenue_per_rvu: Double, favorite_cpts: [String], procedures: [String]){
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.email = email
        self.revenue_per_rvu = revenue_per_rvu
        self.favorite_cpts = favorite_cpts
        self.procedures = procedures
    }
}
