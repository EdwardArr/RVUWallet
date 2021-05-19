//
//  User.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/22/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var email: String
    var first_name: String
    var last_name:String
    var revenue_per_rvu:String
    var favorite_cpts:[String]
//    var password: String
}
