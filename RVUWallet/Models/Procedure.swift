//
//  Procedure.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/16/21.
//

import Foundation

struct Procedure: Identifiable, Codable {
    var id = UUID()
    var cpt: String
    var description: String
    var icd10: String
    var diagnosis: String
    var rvu: Double
    var documentList: [String]
    var procedureDate: Double
    var date: String
}

//#if DEBUG
let proceduresList = [
    Procedure(cpt: "43644", description: "Lap gastric bypass", icd10:"A15", diagnosis: "G00569256681", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "4/3/21"),
    Procedure(cpt: "43646", description: "Lap gastric bypass", icd10:"A15", diagnosis: "G00569256682", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "4/2/21"),
    Procedure(cpt: "43645", description: "Broken Bone Repair", icd10:"A15", diagnosis: "G00569256683", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "4/1/21")
]

//#endif
