//
//  ProceduresMainView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/8/21.
//

import SwiftUI

struct ProceduresMainView: View {
    @State private var presentDateListFilterScreen = false
    
    var proceduresList: [Procedure]
    
    var totalRVU:Double
    
    var revenuePerRVU:Double
    
    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView{
                ProcedureListView(proceduresList: proceduresList, totalRVU:totalRVU, revenuePerRVU:revenuePerRVU)
            }  
        }
        .navigationBarTitle("All Procedures", displayMode: .inline)
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $presentDateListFilterScreen){
            DateListFilterView()
        }

    }
}

struct ProceduresMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProceduresMainView(proceduresList: proceduresList, totalRVU: 200.1, revenuePerRVU: 54.19)

    }
}
