//
//  AddNewCPTCode.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

enum CPTCodeEditMode {
    case new, edit
}

struct CPTCodeEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var cptVM = CPTViewModel()
    
    @StateObject var userVM = UserViewModel()
    
    @ObservedObject var userInfo = UserInfo()
    
    @ObservedObject var physicianVM = PhysicianViewModel()
    
    @AppStorage("userID") var user_id = ""
    
    @State var physician:Physician = Physician(id: "dTsn2jWAdrtAMj4N1zYn", first_name: "Michael", last_name: "Blaney", phone_number: "+1(706)285-3186", email: "mike.blaney@bcofa.com", revenue_per_rvu: 54.19, favorite_cpts: [], procedures: [])
    
    @State var cptCode = ""
    @State var description = ""
    @State var rvu = ""
//    @State var cptColor: Color
    @State var isFavorite = true
    
    @State var cptCodeEditMode: CPTCodeEditMode = .new
    
    @State var cpt:CPT = CPT(id: "", code: "", description: "", rvu: 0.0)
    
    var navigationTitle: Text {
        switch(self.cptCodeEditMode) {
        case .new:
            return Text("New CPT Code")
        case .edit:
            return Text(cpt.description)
        }
    }
    
    var navDisplayMode: NavigationBarItem.TitleDisplayMode {
        switch(self.cptCodeEditMode) {
        case .new:
            return .inline
        case .edit:
            return .large
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                Section{
                    TextField("CPT Code", text: $cpt.code)
                        .keyboardType(.numberPad)
                    
                    TextField("Description", text: $cpt.description)
                    
                    TextField("RVU", text: $rvu)
                        .keyboardType(.decimalPad)
                }
            
//            Section{
//                ColorPicker("Assign Color", selection: $cptColor)
//            }
            
            Section(footer:Text("All new CPT codes will be added to the Favorites List")){
                Button(action: {isFavorite.toggle()}, label: {
                    HStack{
                        Text("Add to Favorites").foregroundColor(.primary)
                        Spacer()
                    
                    if isFavorite {
                        Image(systemName: "star.fill")
                    }else{
                        Image(systemName: "star")
                    }
                    }
                }).disabled(true)
            }
                
                Section{
                    Button {
                        userVM.deleteUserCPT(userVM.user, cpt: userVM.cpt)
                        dismiss()
                    } label: {
                        Text("Delete CPT")
                            .foregroundColor(.red)
                    }

                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(navigationTitle)
            .onAppear(perform: {
                userVM.fetchUser(documentId: self.user_id)
                if cpt.rvu != 0.0 {
                    self.rvu = "\(cpt.rvu)"
                }
                print(rvu)
            })
        .navigationBarTitleDisplayMode(navDisplayMode)
        .navigationBarItems(leading: Button(
                                action: {
                                    handleCancelTapped()},
                                            label: {
                                                Text("Cancel").foregroundColor(.blue).font(.body)
                                            }), trailing: Button(action: {
                                                handleDoneTapped()
                                                dismiss()
                                            }, label: {
                                                Text("Save").font(.body)
                                            }) )
        }
    }
    
    func handleDoneTapped() {
        
        let id = UUID().uuidString
        if cpt.id == ""{
            userVM.cpt.id = id
        }else{
            userVM.cpt.id = cpt.id
        }
        
        userVM.cpt.description = cpt.description
        userVM.cpt.code = cpt.code
        userVM.cpt.rvu = Double(rvu) ?? 0.0
                                  
//        if isFavorite == true {
//            physicianVM.physician.favorite_cpts.append(id)
//        }
//        cptVM.save()
//        physicianVM.addCPTForPhysician(physician: physician)
        userVM.saveCPT()
//        physicianVM.updateFavoriteCPTsList(physician: physician, cpt: id)
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddNewCPTCode_Previews: PreviewProvider {
    static var previews: some View {
        CPTCodeEditView(cpt: CPT(id: "", code: "", description: "", rvu: 0.0))
    }
}
