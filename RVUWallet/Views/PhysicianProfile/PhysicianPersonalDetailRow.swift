//
//  PhysicianPersonalDetailRow.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/12/21.
//

import SwiftUI

struct PhysicianPersonalDetailRow: View {
    
    @State var personal:String = "Michael"
    
    var descriptor:String
    
    var personalInfo:String
    
    var keyboardType: UIKeyboardType
    
    var mode:personalDetailsMode
    
    var body: some View {
        
        HStack{
            
            Text(descriptor)
            
            Spacer()
            
            if mode == .view{
                Text(personalInfo)
            }else if mode == .edit {
                TextField("", text: $personal)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                
            }
            
        }
    }
}

struct PhysicianPersonalDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        PhysicianPersonalDetailRow(descriptor:"First Name", personalInfo: "Michael", keyboardType: .namePhonePad, mode:.edit)
    }
}
