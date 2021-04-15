//
//  SummaryComponentsView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct RecentProceduresList: View {
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Recent Diagnosis")
                .font(.title2)
                .bold()
            
            ForEach(proceduresList.prefix(3)){procedure in
                NavigationLink(
                    destination: ProcedureDetailView(procedure: procedure),
                    label: {
                        ProcedureRowView(procedure: procedure)
                            .padding(.vertical,20)
                    })
            
                
            }
            
        }
    }
}

struct SummaryComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentProceduresList()
            .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea(.all)
    }
}
