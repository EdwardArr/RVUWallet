//
//  AddNewCPTCode.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

struct AddCPTCodeView: View {
    
    @State var cptCode = ""
    @State var description = ""
    @State var rvu = ""
    @State var cptColor: Color
    @State var isFavorite = false
    
    var body: some View {
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
        }.listStyle(GroupedListStyle())
    }
}

struct AddNewCPTCode_Previews: PreviewProvider {
    static var previews: some View {
        AddCPTCodeView(cptColor: .blue)
    }
}
