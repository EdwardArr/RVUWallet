//
//  ProcedureRowView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/1/21.
//

import SwiftUI


enum timeFormat {
    case today, yesterday, this_week
}

struct ProcedureRowView: View {
    var procedure: Procedure
    
    var body: some View {
        
        let date = Date(timeIntervalSince1970: procedure.procedure_date)
        let calendar = Calendar.current
        let month = String(calendar.component(.month, from: date))
        let day = String(calendar.component(.day, from: date))
        let year = String(calendar.component(.year, from: date)).dropFirst(2)
        
        ZStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
            HStack(alignment: .top) {
                VStack(alignment:.leading, spacing:1){
                    Text(procedure.cpt_description)
                        .foregroundColor(.primary)
                    Text(procedure.hospital_barcode)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                Spacer()
                HStack(spacing:1){
                    Text("\(month)/\(day)/\(String(year))").font(.footnote).foregroundColor(.secondary)
                    Image(systemName: "chevron.right").font(.footnote).foregroundColor(.secondary)
                }
            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }.frame(height:55)
    }
}


struct ProcedureRowWithoutBackgroundView: View {
   
    var procedure: Procedure
    
    var body: some View {
        
        let date = Date(timeIntervalSince1970: procedure.procedure_date)
        let calendar = Calendar.current
        let month = String(calendar.component(.month, from: date))
        let day = String(calendar.component(.day, from: date))
        let year = String(calendar.component(.year, from: date))
   
            HStack(alignment: .top) {
                VStack(alignment:.leading, spacing:5){
                    
                    Text(procedure.cpt_description)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(procedure.hospital_barcode)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                Spacer()
                HStack(spacing:0){
                    Text("\(month)/\(day)/\(year)").font(.footnote).foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .font(Font.footnote.weight(.medium))
                        
                }
            }.padding(.vertical,1)
    }
}

//struct ProcedureRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProcedureRowView(procedure: proceduresList[0])
//    }
//}
