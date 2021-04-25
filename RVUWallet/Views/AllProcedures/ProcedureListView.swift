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
//        ZStack{
//            Rectangle()
//                .foregroundColor(Color(UIColor.systemGroupedBackground))
//                .edgesIgnoringSafeArea(.all)
//            ScrollView(showsIndicators: false){
                Section(header:
                            VStack{
                            HStack{
                                Text("April 2021")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                            }.padding(.top)
//                                SummaryView(proceduresList: proceduresList, totalRVU: totalRVU, revenuePerRVU: revenuePerRVU)
                            }){
                    ForEach(proceduresList
                                .sorted {$0.procedure_date > $1.procedure_date}
                    ){ procedure in
                        
//                        if procedure.procedure_date == 0.0 {
                        NavigationLink(
                            destination: ProcedureDetailView(procedure: procedure, cpt: cptList[0]),
                            label: {
                                ProcedureRowView(procedure: procedure).padding(.vertical,-1)
                            })
//                        }
                    }
                }
//            }.listStyle(InsetGroupedListStyle())
//            .navigationBarTitle(Text("All Procedures"), displayMode: .large)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//        }
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
        }.onAppear {
//            proceduresVM.subscribe()
        }
        .onDisappear {
//            proceduresVM.unsubscribe()
        }
    }
    
     
}

struct ProcedureList_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureListView(proceduresList: proceduresList, totalRVU: 200.1, revenuePerRVU: 54.19)
    }
}
