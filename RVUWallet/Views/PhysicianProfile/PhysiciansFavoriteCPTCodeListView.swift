//
//  PhysiciansFavoriteCPTCodeListView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

struct PhysiciansFavoriteCPTCodeListView: View {
    
    @State private var presentAddCPTCodeScreen = false
    
    var body: some View {
        List{
            Section{
                Button (action:{
                    presentAddCPTCodeScreen.toggle()
                } ,label: {
                    Text("Add New CPT Code")
                })
.sheet(isPresented: $presentAddCPTCodeScreen){
AddCPTCodeView(cptColor: .blue)
                }
            }
        FavoriteCPTCodeListView()
        }
            .navigationBarTitle("Favorite CPT Codes")
            .navigationBarItems(trailing: Button(action: {}, label: {
                Text("Edit")
            }))
            .listStyle(InsetGroupedListStyle())
    }
}

struct PhysiciansFavoriteCPTCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        PhysiciansFavoriteCPTCodeListView()
    }
}
