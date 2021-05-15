//
//  FavoriteCPTCodeListView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/1/21.
//

import SwiftUI

enum FavoritesViewMode {
  case view, edit, select
}

struct FavoritesView: View {
    
    @ObservedObject var physiciansVM = PhysiciansViewModel()
    
    @ObservedObject var cptsVM = CPTsViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @AppStorage("userID") var user_id = ""
    
//    @State var physician:Physician = Physician(id: "dTsn2jWAdrtAMj4N1zYn", first_name: "Michael", last_name: "Blaney", phone_number: "+1(706)285-3186", email: "mike.blaney@bcofa.com", revenue_per_rvu: 54.19, favorite_cpts: ["12","122"], procedures: [])
    
    @State var text = ""
    @State var isEditing = false
    
    @State var isSelected = false
    
    @State var selection: CPT?
    
    @State private var presentAddCPTCodeScreen = false
    
    @State var presentFavoriteCPTCodeListScreen = false
    
    @State var mode: FavoritesViewMode = .view
    
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
        }
    }
    
    var navDisplayMode: NavigationBarItem.TitleDisplayMode {
        switch(self.mode) {
        case .edit:
            return .inline
        case .view:
            return .large
        case .select:
            return .inline
//                .font(.title3)
        }
    }
    
    var body: some View {
//        NavigationView{
        List{
            
//            Text(getFavoriteCPTIDs())
            
            if mode == .edit{
                Button (action:{
                    
                    presentAddCPTCodeScreen.toggle()
                    
                } ,label: {
                    Text("Add New CPT Code").font(.body)
                })
                .sheet(isPresented: $presentAddCPTCodeScreen){
                    CPTCodeEditView()
                }
            }
            
            Section(header:
                        HStack{
                            sectionHeader
                                .font(.title3)
                                .foregroundColor(.primary)
                                .bold()
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
//                    HStack{
                    FavoriteCPTRowView(userVM: UserViewModel(cpt: cpt), selected: $selection, isSelected: $isSelected, cpt: cpt, user: userVM.user, mode: mode)
//                    }
//                    .padding(.vertical,5)
                }
            }
            .textCase(nil)
        }
        .navigationBarTitle(navigationTitle)
        .onAppear(perform: {
            userVM.fetchCPTs(documentId: user_id)
            userVM.fetchUser(documentId: user_id)
        })
        .navigationBarBackButtonHidden(isBackButtonHidden)
        .navigationBarTitleDisplayMode(navDisplayMode)
        .navigationBarItems(leading: Button(
                                action: {
                                    
                                    mode = .view
                                   
                                },
                                label: {
                                    leadingNavItem.font(.body)}), trailing:
                                Button(
                                    action: {
                                        if mode == .edit{
                                            mode = .view
                                        }else if mode == .view{
                                        mode = .edit
                                        }
                                        
        }, label: {
            trailingNavItem.font(.body)
//            Text(mode == .view ? "Edit" : "Done")
        })
//                                .sheet(isPresented: $presentFavoriteCPTCodeListScreen){
//                                    FavoriteCPTCodeListView(mode:.edit)
//                                                }
        )
        .listStyle(InsetGroupedListStyle())
//    }
    }
    
//    func getFavoriteCPTIDs() -> String{
//        var favorite_cpts = [String]()
//        
//        for i in physiciansVM.physicians{
//            for x in i.favorite_cpts{
//                favorite_cpts.append(x)
//            }
//        }
//        print(favorite_cpts)
//        return favorite_cpts[0]
//    }
    
}

struct FavoriteCPTCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(selection: cptList[0])
    }
}
