//
//  ProcedureRowView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/1/21.
//

import SwiftUI

struct ProcedureRowView: View {
    var procedure: Procedure
    var body: some View {
        
        ZStack(alignment:.leading){
            Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
            HStack(alignment: .top) {
                VStack(alignment:.leading){
                    
                    Text(procedure.description)
//                        .foregroundColor(.secondary)
                        .foregroundColor(.primary)
//                    .foregroundColor(fontColorDescription(procedure: procedure))
//                        .font(.subheadline).bold()
                    Spacer()
                    Text(procedure.diagnosis)
                        .font(.title3)
                        .foregroundColor(fontColorDescription(procedure: procedure))
                        
                    //                    Text(procedure.idc).font(.footnote)
                }
                Spacer()
                HStack{
                    Text(procedure.date).font(.footnote).foregroundColor(.secondary)
                    Image(systemName: "chevron.right").font(.footnote).foregroundColor(.secondary)
                }
            }.padding()
        }.frame(height:44)
    }
    
    func fontColorDescription(procedure: Procedure) -> Color {
        let cpt = cptList.filter{$0.code == procedure.cpt}.first
        let color: Color = cpt!.color
//        if let cpt = cptList.filter{$0.code == procedure.cpt}.first {
//            let color = cpt.color
//        }
        return color
    }
}


struct ProcedureRowWithoutBackgroundView: View {
    var procedure: Procedure
    var body: some View {
        
   
            HStack(alignment: .top) {
                VStack(alignment:.leading, spacing:5){
                    
                    Text(procedure.description)

                    .foregroundColor(fontColorDescription(procedure: procedure))
                        .font(.subheadline)
                        .fontWeight(.medium)
//                    Spacer()
                    Text(procedure.diagnosis)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
//                        .foregroundColor(fontColorDescription(procedure: procedure))
                        
                    //                    Text(procedure.idc).font(.footnote)
                }
                Spacer()
                HStack{
                    Text(procedure.date).font(.footnote).foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        
                }
            }.padding(.vertical,5)
      
    }
    
    func fontColorDescription(procedure: Procedure) -> Color {
        let cpt = cptList.filter{$0.code == procedure.cpt}.first
        let color: Color = cpt!.color
//        if let cpt = cptList.filter{$0.code == procedure.cpt}.first {
//            let color = cpt.color
//        }
        return color
    }
}

struct ProcedureRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureRowView(procedure: proceduresList[0])
    }
}
