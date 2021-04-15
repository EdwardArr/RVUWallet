//
//  SelectCPTView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/6/21.
//

import SwiftUI

struct SelectCPTView: View {
    
    
    @State var presentAddCPTCodeScreen = false
    @State var presentEditFavoritesScreen = false
    
    var mode:FavoritesViewMode = .select
    
    var body: some View {
        
        List{
            Section(header:
                        HStack(alignment:.bottom){
                            Text("Favorites")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.primary)
                                .padding(.top)
                            Spacer()
                            Button(
                                action: {
                                    presentEditFavoritesScreen.toggle()
                                },
                                label: {
                                    Text("Edit")
                                        .font(.body)
                                }).sheet(isPresented: $presentEditFavoritesScreen){
                                    FavoritesWithNavBarView(mode:.edit)
                                }
                        })
            {
                //        FavoritesView(mode:.select)
                ForEach(cptList) {cpt in
                    HStack{
                        FavoriteCPTRowView(cpt: cpt, mode: mode)
                    }.padding(.vertical,5)
                }
                
            }
            .textCase(nil)
            
            
        }
        
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Select CPT Code", displayMode: .inline)
        .navigationBarItems(trailing:
                                
                                Button {
                                    presentAddCPTCodeScreen.toggle()
                                } label: {
                                    Image(systemName: "plus").font(.body)
                                })
        .sheet(isPresented: $presentAddCPTCodeScreen){
            CPTCodeEditView(cptColor: .blue)
        }
        
    }
}

struct SelectCPTView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCPTView()
    }
}
