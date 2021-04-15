//
//  ProcedureDetailView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI


struct ProcedureDetailView: View {
    
    var procedure:Procedure
    
    var body: some View {
        
        
        VStack{
            List{
//                Section{
//                    HStack{
//                        Spacer()
//                        Text("14.98").font(.largeTitle).bold()
//                        Spacer()
//                    }
//                }.listRowBackground(Color(UIColor.systemGroupedBackground))
                Section{
                    VStack(alignment:.leading, spacing:1){
                        Text("Hospital Code")
                            .font(.subheadline)

                        Text(procedure.diagnosis)
                            .font(.body)
                        
                    }.padding(.vertical,10)
                
                }
                Section{
                    VStack(alignment:.leading, spacing:1){
                        Text("Procedure Date")
                            .font(.subheadline)

                        Text("March 16, 2021")
                            .font(.body)
                        
                    }.padding(.vertical,10)
                
                }
                VStack(alignment:.leading, spacing:1){
                    Text("CPT Code")
                        .font(.subheadline)
                    Text("34644")
                        .font(.body)
                }
                
                VStack(alignment:.leading, spacing:1){
                    Text("Description")
                        .font(.subheadline)
                    Text("Lap Gastric Bypass")
                        .font(.body)
                }
                VStack(alignment:.leading, spacing:1){
                    Text("RVU")
                        .font(.subheadline)
                   
                    Text("14.98")
                        .font(.body)
                }
            }
        }
//        .background(Color.blue)
        .listRowBackground(Color.red)
        .navigationBarTitle(procedure.diagnosis, displayMode:.large)
        .navigationBarItems(trailing: Button(action: {
            print("Editing procedure")
        }, label: {
            Text("Edit").font(.body)
        }).disabled(true))
        .listStyle(InsetGroupedListStyle())
        
        
    }
}

struct ProcedureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureDetailView(procedure: proceduresList[0])
    }
}
