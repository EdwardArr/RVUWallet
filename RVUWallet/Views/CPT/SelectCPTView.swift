//
//  SelectCPTView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/6/21.
//

import SwiftUI

struct SelectCPTView: View {
    
    @State var presentAddCPTCodeScreen = false
    var body: some View {
        List{
            Section(header:Text("Favorites")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.top)){
        FavoriteCPTCodeListView()
            }
            .textCase(nil)
            
        }
        
            .listStyle(GroupedListStyle())
        .navigationBarTitle("Select CPT Codes", displayMode: .inline)
        .navigationBarItems(trailing:
                                
                                Button {
                                    presentAddCPTCodeScreen.toggle()
                                } label: {
                                    Image(systemName: "plus").font(.body)
                                })
        .sheet(isPresented: $presentAddCPTCodeScreen){
            AddCPTCodeView(cptColor: .blue)
                                }
        
    }
}

struct SelectCPTView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCPTView()
    }
}
