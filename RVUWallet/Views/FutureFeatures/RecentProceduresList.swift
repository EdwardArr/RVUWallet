//
//  SummaryComponentsView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct RecentProceduresList: View {
   
    var proceduresList:[Procedure]
    
    var totalRVU:Double
    
    var revenuePerRVU:Double
    
    var cpt:CPT
    
    var body: some View {
        
        VStack(alignment: .leading, spacing:5){
            HStack{
                Text("Recent Procedures")
                    .foregroundColor(.primary)
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {}, label: {
                    NavigationLink(
                        destination:
                            ProceduresMainView(proceduresList: proceduresList, totalRVU: totalRVU, revenuePerRVU: revenuePerRVU)
                            .navigationBarLargeTitleItems(trailing: EmptyView())
                        ,
                        label: {
                            Text("Show More")
                        }
                    )
                })
            }.padding(.bottom,5)
            ForEach(proceduresList
                        .sorted {$0.procedure_date > $1.procedure_date}
                        .prefix(3))
            {procedure in
                NavigationLink(
                    destination: ProcedureDetailView(procedure: procedure, cpt: cpt),
                    label: {
                        ProcedureRowView(procedure: procedure)
                    }
                )
            }

        }
    }
}

//struct SummaryComponentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentProceduresList(proceduresList: proceduresList, totalRVU: 200.1, revenuePerRVU: 54.19,cpt: cptList[0])
//            .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea(.all)
//    }
//}

