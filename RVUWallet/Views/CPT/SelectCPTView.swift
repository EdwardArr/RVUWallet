//
//  SelectCPTView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/6/21.
//

import SwiftUI

struct SelectCPTView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var cptsVM = CPTsViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @AppStorage("userID") var user_id = ""
    
    @State var presentAddCPTCodeScreen = false
    
    @State var presentEditFavoritesScreen = false
    
    @Binding var isSelected:Bool
    
    @Binding var selection: CPT?
    
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
                                })
//                                .disabled(true)

                                .sheet(isPresented: $presentEditFavoritesScreen){
                                    FavoritesWithNavBarView(mode:.edit)
                                }
                        })
            {
                //        FavoritesView(mode:.select)
                ForEach(userVM.cpts) {cpt in
                    HStack{
                        FavoriteCPTRowView(selected: $selection, isSelected: $isSelected, cpt: cpt, mode: mode)
                    }.padding(.vertical,5)
                }
                
            }
            .textCase(nil)
            
            
        }
        
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Select CPT Code", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                        }, label: {
            EmptyView()
        })
                                ,trailing:
                                
                                Button {
                                    presentAddCPTCodeScreen.toggle()
                                } label: {
                                    Image(systemName: "plus").font(.body)
                                })
        .onAppear(perform: {
            userVM.fetchCPTs(documentId: self.user_id)
            print(isSelected)
//            dismiss()
        })
        .sheet(isPresented: $presentAddCPTCodeScreen){
            CPTCodeEditView()
        }
        
    }
    
    
    func dismiss(){
        if self.isSelected == false{
        presentationMode.wrappedValue.dismiss()
        }
    }
    
}

//struct SelectCPTView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectCPTView()
//    }
//}
