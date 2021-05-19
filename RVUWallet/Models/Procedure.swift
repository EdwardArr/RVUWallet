//
//  Procedure.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/16/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Procedure: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var cpt_id: String
    var cpt_code: String
    var cpt_description: String
    var cpt_rvu: Double
//    var icd10: String
    var hospital_barcode: String
    var primary_md: String
    var procedure_date: Double
    var date: String
    
    init(cpt_id: String, cpt_code: String, cpt_description: String, cpt_rvu: Double, hospital_barcode: String, primary_md: String, procedure_date: Double, date: String){
        self.cpt_id = cpt_id
        self.cpt_code = cpt_code
        self.cpt_description = cpt_description
        self.cpt_rvu = cpt_rvu
        self.hospital_barcode = hospital_barcode
        self.primary_md = primary_md
        self.procedure_date = procedure_date
        self.date = date
    }
}

//#if DEBUG
let proceduresList = [
    Procedure(cpt_id: "", cpt_code: "34644", cpt_description: "", cpt_rvu: 0.0, hospital_barcode: "G00569256681", primary_md: "dTsn2jWAdrtAMj4N1zYn", procedure_date: 0.0, date: "4/15/21")
//    Procedure(cpt_id: "", cpt: "43644", description: "Lap gastric bypass", icd10:"A15", hospital_code: "G00569256681", rvu: 14.98, physicians: [], procedure_date: 0.0, date: "4/3/21"),
//    Procedure(cpt_id: "", cpt: "43646", description: "Lap gastric bypass", icd10:"A15", hospital_code: "G00569256682", rvu: 14.98, physicians: [], procedure_date: 0.0, date: "4/2/21"),
//    Procedure(cpt_id: "", cpt: "43645", description: "Broken Bone Repair", icd10:"A15", hospital_code: "G00569256683", rvu: 14.98, physicians: [], procedure_date: 0.0, date: "4/1/21")
]

//#endif
