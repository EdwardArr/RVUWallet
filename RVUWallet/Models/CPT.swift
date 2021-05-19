//
//  CPT.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/31/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CPT: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var code: String
    var description: String
    var rvu: Double

    
    init(id: String, code: String, description: String, rvu: Double){
        self.id = id
        self.code = code
        self.description = description
        self.rvu = rvu
    }
}

//#if DEBUG
var cptList = [
    CPT(id: UUID().uuidString, code: "43644", description: "Lap Gastric Bypass", rvu: 423.95),
    CPT(id: "2", code: "43645", description: "Appendectomy", rvu: 104.95),
    CPT(id: "3", code: "43646", description: "Breast Biopsy", rvu: 142.95),
    CPT(id: "4", code: "43647", description: "Carotid Endarterectomy ", rvu: 392.95),
    CPT(id: "5", code: "43648", description: "Cataract Surgery", rvu: 104.95),
    CPT(id: "6", code: "43649", description: "Cesarean Section", rvu: 233.95),
    CPT(id: "7", code: "43650", description: "Colonoscopy", rvu: 302.95),
    CPT(id: "8", code: "43651", description: "Cholecystectomy", rvu: 104.95),
    CPT(id: "9", code: "43652", description: "Coronary Artery Bypass", rvu: 142.95),
    CPT(id: "10", code: "43653", description: "Hysterectomy", rvu: 14.95),
    CPT(id: "11", code: "43654", description: "Joint Replacement", rvu: 281.95),
    CPT(id: "12", code: "43655", description: "Broken Bone Repair", rvu: 104.95),
    CPT(id: "13", code: "43656", description: "Circumcision", rvu: 142.95)
]
//#endif


//var cptList = [
//    CPT(id: "1", code: "43644", description: "Lap Gastric Bypass", rvu: 423.95, color: .purple),
//    CPT(id: 2, code: "43644", description: "Appendectomy", rvu: 104.95, color: .green),
//    CPT(id: 3, code: "43644", description: "Breast Biopsy", rvu: 142.95, color: .red),
//    CPT(id: 4, code: "43644", description: "Carotid Endarterectomy ", rvu: 392.95, color: .orange),
//    CPT(id: 5, code: "43644", description: "Cataract Surgery", rvu: 104.95, color: Color(UIColor.systemTeal)),
//    CPT(id: 6, code: "43644", description: "Cesarean Section", rvu: 233.95, color: Color(UIColor.cyan)),
//    CPT(id: 7, code: "43644", description: "Colonoscopy", rvu: 302.95, color: Color(UIColor.systemIndigo)),
//    CPT(id: 8, code: "43644", description: "Cholecystectomy", rvu: 104.95, color: Color(UIColor.brown)),
//    CPT(id: 9, code: "43644", description: "Coronary Artery Bypass", rvu: 142.95, color: .pink),
//    CPT(id: 10, code: "43644", description: "Hysterectomy", rvu: 14.95, color: .purple),
//    CPT(id: 11, code: "43644", description: "Joint Replacement", rvu: 281.95, color: .blue),
//    CPT(id: 12, code: "43645", description: "Broken Bone Repair", rvu: 104.95, color: .green),
//    CPT(id: 13, code: "43646", description: "Circumcision", rvu: 142.95, color: .red)
//]
