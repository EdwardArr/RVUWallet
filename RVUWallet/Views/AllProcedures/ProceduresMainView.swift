//
//  ProceduresMainView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/8/21.
//

import SwiftUI

struct ProceduresMainView: View {
    @State private var presentDateListFilterScreen = false
    var body: some View {
  
        ProcedureMainBackgroundView(dateSelected: 1)
            .navigationBarTitle("All Procedures", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                print("Button pressed to filter all procedures by date range")
                presentDateListFilterScreen.toggle()
            }, label: {
                Text("This month").font(.body)
            }))
            .sheet(isPresented: $presentDateListFilterScreen){
                DateListFilterView()
            }
        
    }
}


struct ProcedureMainBackgroundView: View {
    @State var dateSelected: Int
    
    var body: some View {
        ZStack(alignment:.bottom){
            AllProceduresListView()
//            SegmentedPicker(items: ["Years","Months", "Days"], selection: $dateSelected)
//                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 40, trailing: 10))
        }
        .listStyle(InsetGroupedListStyle())
//        .background(Color(UIColor.systemGroupedBackground))
//        .ignoresSafeArea()
    }
}

struct ProceduresMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProceduresMainView()
    }
}
