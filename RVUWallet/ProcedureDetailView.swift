//
//  ProcedureDetailView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI


struct ProcedureDetailView: View {
    
    var body: some View {
        
        List{
            Section{
                VStack(alignment:.leading){
                    Text("Procedure date")
                        .font(.callout)
                        .bold()
                        .padding(.top,5)
                    Spacer()
                    Text("March 16 2021").font(.title3)
                        .padding(.bottom,5)
                    
                }
            }
            VStack(alignment:.leading){
                Text("CPT")
                    .font(.callout)
                    .bold()
                    .padding(.top,5)
                Spacer()
                Text("34644")
                    .font(.title3)
                    .padding(.bottom,5)
            }
            
            VStack(alignment:.leading){
                Text("Description")
                    .font(.callout)
                    .bold()
                    .padding(.top,5)
                Spacer()
                Text("Lap Gastric Bypass")
                    .font(.title3).padding(.bottom,5)
            }
            VStack(alignment:.leading){
                
                Text("RVU")
                    .font(.callout)
                    .bold()
                    .padding(.top,5)
                Spacer()
                Text("14.98")
                    .font(.title3)
                    .padding(.bottom,5)
               
            }
            Section{
                VStack(alignment:.leading){
                    Text("Photo")
                        .font(.callout)
                        .bold()
                        .padding(.top,5)
                    Spacer()
                    
                }
            }
        }
        .navigationBarTitle("", displayMode:.inline)
        .navigationBarItems(trailing: Button(action: {
            print("Editing procedure")
        }, label: {
            Text("Edit").font(.body)
        }))
        .listStyle(InsetGroupedListStyle())
        
    }
}

struct ProcedureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureDetailView()
    }
}
