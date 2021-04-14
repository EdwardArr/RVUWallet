//
//  ProcedureList.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/1/21.
//

import SwiftUI

struct ProcedureListView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(UIColor.systemGroupedBackground))
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false){
                Section(header:
                            HStack{
                                Text("April 2021")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                            }.padding(.top)){
                    ForEach(proceduresList){ procedure in
                        
                        NavigationLink(
                            destination: ProcedureDetailView(),
                            label: {
                                ProcedureRowView(procedure: procedure).padding(.vertical, 17)
                            })
                    }
                }
            }
            .navigationBarTitle(Text("All Procedures"), displayMode: .large)
            
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct AllProceduresListView: View{
    var body: some View {
        List{
            Section(header:SummaryView( isFilterButtonHidden: true)){
                ForEach(proceduresList){ procedure in
                    ProcedureRowWithoutBackgroundView(procedure: procedure)
                        .background(NavigationLink(                                 destination: ProcedureDetailView(),                                   label: { EmptyView() }).hidden())
                        .buttonStyle(PlainButtonStyle())
                        
                }
            }.textCase(nil)
        }
    }
    
     
}

struct ProcedureList_Previews: PreviewProvider {
    static var previews: some View {
        AllProceduresListView()
    }
}
