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
//            .listStyle(PlainListStyle())
            
        }
        .navigationBarTitle("All Procedures", displayMode: .automatic)
        .navigationBarItems(trailing: Button(action: {
            print("Button pressed to filter all procedures by date range")
            presentDateListFilterScreen.toggle()
        }, label: {
            Text("This month").font(.body)
        }).disabled(true))
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $presentDateListFilterScreen){
            DateListFilterView()
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}


//struct ProcedureMainBackgroundView: View {
//    @State var dateSelected: Int
//
//    var body: some View {
//        ZStack(alignment:.bottom){
//            ProcedureListView()
//            SegmentedPicker(items: ["Years","Months", "Days"], selection: $dateSelected)
//                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 40, trailing: 10))
//        }

//        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        
//    }
//}

struct ProceduresMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProceduresMainView(proceduresList: proceduresList, totalRVU: 200.1, revenuePerRVU: 54.19)
    }
}
