//
//  Procedure.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/16/21.
//

import Foundation

struct Procedure: Codable {
    var cpt: String
    var description: String
    var rvu: Double
    var documentList: [String]
    var procedureDate: Double
    var date: String
}

#if DEBUG
let proceduresList = [
    Procedure(cpt: "43644", description: "Lap gastric bypass", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "March 2021"),
    Procedure(cpt: "43644", description: "Lap gastric bypass", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "February 2021"),
    Procedure(cpt: "43644", description: "Lap gastric bypass", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "January 2021"),
    Procedure(cpt: "43644", description: "Lap gastric bypass", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "December 2020"),
    Procedure(cpt: "43644", description: "Lap gastric bypass", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "November 2020"),
    Procedure(cpt: "43644", description: "Lap gastric bypass", rvu: 14.98, documentList: [], procedureDate: 0.0, date: "October 2020")
]

#endif
