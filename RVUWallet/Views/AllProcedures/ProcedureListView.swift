//
//  ProcedureList.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/1/21.
//

import SwiftUI

struct ProcedureListView: View {
    
    var proceduresList:[Procedure]
    
    var totalRVU:Double
    
    var revenuePerRVU:Double
    
    var body: some View {

                Section(header:
                            VStack{
                            HStack{
                                Text(currentMonth())
                                    .font(.title3)
                                    .bold()
                                Spacer()
                            }
                            .padding(.top)
                            }){
                    ForEach(proceduresList
                                .sorted {$0.procedure_date > $1.procedure_date}
                    ){ procedure in
                        NavigationLink(
                            destination: ProcedureDetailView(procedure: procedure, cpt: cptList[0]),
                            label: {
                                ProcedureRowView(procedure: procedure)
                            })
                    }
                }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
    func currentMonth()->String{
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: now)
    }
}

struct AllProceduresListView: View{
    
    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    var procedures_list:[Procedure]
    
    var body: some View {
        List{
            Section(header:SummaryView(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: 54.19).padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 10))){
                ForEach(procedures_list
                            .sorted {$0.procedure_date > $1.procedure_date})
                { procedure in
                    ProcedureRowWithoutBackgroundView(procedure: procedure)
                        .background(NavigationLink(
                                        destination:
                                            ProcedureDetailView(procedure: procedure, cpt: cptList[0]),
                                        label: {
                                            EmptyView() }).hidden())
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .textCase(nil)
        }
    }  
}

struct ProcedureList_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureListView(proceduresList: proceduresList, totalRVU: 200.1, revenuePerRVU: 54.19)
    }
}
