//
//  FavoritesWithNavBarView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/12/21.
//

import SwiftUI

struct FavoritesWithNavBarView: View {
   
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var cptsVM = CPTsViewModel()
    
    @State var selection: CPT?
    
    @State var text = ""
    @State var isEditing = false
    
    @State var isSelected = false
    
    @State private var presentAddCPTCodeScreen = false
    @State var presentFavoriteCPTCodeListScreen = false
    
    @ObservedObject var userVM = UserViewModel()
    
    @AppStorage("userID") var user_id = ""
    
    @State var mode: FavoritesViewMode = .edit
    
    var isBackButtonHidden: Bool {
        switch(self.mode) {
        case .edit:
            return true
        case .view:
                return false
        case .select:
            return false
            }
    }
    
    var navigationTitle: Text {
        switch(self.mode) {
        case .edit:
            return Text("Edit Favorites")
        case .view:
                return Text("Favorites")
        case .select:
            return Text("Select CPT Code")
        }
    }
    
    var sectionHeader: Text {
        switch(self.mode) {
        case .edit:
            return Text("CPT Codes")
        case .view:
                return Text("CPT Codes")
        case .select:
            return Text("Favorites")
        }
    }
    
    var leadingNavItem: some View {
        switch(self.mode) {
        case .edit:
            return Text("Cancel")
        case .view:
                return Text("")
        case .select:
            return Text("Cancel")
        }
    }
    
    var trailingNavItem: some View {
        switch(self.mode) {
        case .edit:
            return AnyView(Text("Done"))
        case .view:
                return AnyView(Text("Edit"))
        case .select:
            return AnyView(Image(systemName: "plus"))
//                .font(.title3)
        }
    }
    
    var body: some View {
        NavigationView{
        List{
            if mode == .edit{
                Button (action:{
                    
                    presentAddCPTCodeScreen.toggle()
                    
                } ,label: {
                    Text("Add New CPT Code").font(.body)
                })
                
            }
            
            Section(header:
                        HStack{
                            sectionHeader.font(.title3).foregroundColor(.primary).bold()
                            Spacer()
                            if mode == .select{
                                Button(action: {
                                    mode = .edit
                                    self.isEditing = true
                                }, label: {
                                    Text("Edit").font(.body)
                                })
                                                                
                            }}.padding(.top)
            ){
                ForEach(userVM.cpts) {cpt in
                    FavoriteCPTRowView(selected: $selection, isSelected: $isSelected, cpt: cpt, user: userVM.user, mode: mode)
                }
            }.textCase(nil)
        }
        .navigationBarTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            userVM.fetchCPTs(documentId: self.user_id)
        })
        .navigationBarBackButtonHidden(isBackButtonHidden)
        .navigationBarItems(leading: Button(
                                action: {
                                    
                                    handleCancelTapped()
                                    
                                },
                                label: {
                                    leadingNavItem.font(.body)}), trailing:
                                Button(
                                    action: {
                                        handleCancelTapped()
        }, label: {
            trailingNavItem.font(.body)

        })

        )
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $presentAddCPTCodeScreen){
            CPTCodeEditView()
        }
    }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct FavoritesWithNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesWithNavBarView()
    }
}
