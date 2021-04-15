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
    
    @State var cptCode = ""
    @State var description = ""
    @State var rvu = ""
    @State var cptColor: Color
    @State var isFavorite = false
    
    var cptCodeEditMode: CPTCodeEditMode = .new
    
    var navigationTitle: Text {
        switch(self.cptCodeEditMode) {
        case .new:
            return Text("New CPT Code")
        case .edit:
                return Text(description)
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
                TextField("CPT Code", text: $cptCode)
                    .keyboardType(.numberPad)
            
                TextField("Description", text: $description)
            
                TextField("RVU", text: $rvu)
                    .keyboardType(.decimalPad)
            }
            Section{
                ColorPicker("Assign Color", selection: $cptColor)
            }
            Section{
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
                })
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(navDisplayMode)
        .navigationBarItems(leading: Button(
                                action: {
                                    handleCancelTapped()},
                                            label: {
                                                Text("Cancel").foregroundColor(.blue).font(.body)
        }) )
        }
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
        CPTCodeEditView(cptColor: .blue)
    }
}
