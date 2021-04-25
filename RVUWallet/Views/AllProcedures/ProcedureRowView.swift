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
//                        .foregroundColor(.secondary)
                        .foregroundColor(.primary)
//                    .foregroundColor(fontColorDescription(procedure: procedure))
//                        .font(.subheadline).bold()
//                    Spacer()
                    Text(procedure.hospital_barcode)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
//                        .foregroundColor(fontColorDescription(procedure: procedure))
                        
                    //                    Text(procedure.idc).font(.footnote)
                }
                Spacer()
                HStack{
                    Text("\(month)/\(day)/\(String(year))").font(.footnote).foregroundColor(.secondary)
                    Image(systemName: "chevron.right").font(.footnote).foregroundColor(.secondary)
                }
            }.padding()
        }
//        .frame(height:44)
    }
    
//    func fontColorDescription(procedure: Procedure) -> Color {
//        let cpt = cptList.filter{$0.code == procedure.cpt}.first
//        let color: Color = cpt!.color
////        if let cpt = cptList.filter{$0.code == procedure.cpt}.first {
////            let color = cpt.color
////        }
//        return color
//    }
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
//                    .foregroundColor(fontColorDescription(procedure: procedure))
                        .font(.subheadline)
                        .fontWeight(.medium)
//                    Spacer()
                    Text(procedure.hospital_barcode)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
//                        .foregroundColor(fontColorDescription(procedure: procedure))
                        
                    //                    Text(procedure.idc).font(.footnote)
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
//            .padding(.vertical,5)
      
    }
    
//    func fontColorDescription(procedure: Procedure) -> Color {
//        let cpt = cptList.filter{$0.code == procedure.cpt}.first
//        let color: Color = cpt!.color
////        if let cpt = cptList.filter{$0.code == procedure.cpt}.first {
////            let color = cpt.color
////        }
//        return color
//    }
}

//struct ProcedureRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProcedureRowView(procedure: proceduresList[0])
//    }
//}
