//
//  CPTRowView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

struct FavoriteCPTRowView: View {
    
    @State var presentCPTCodeEditScreen = false
    
    var cpt:CPT
    
    var mode:FavoritesViewMode
    
    var body: some View {
        HStack{
            if mode == .edit {
                Button(action:{
                    print("\(cpt.description) is in process to be deleted.")
                }, label:{
                Image(systemName: "minus.circle.fill").font(.body).foregroundColor(.red)
                }).buttonStyle(BorderlessButtonStyle())
            }
            VStack(alignment:.leading, spacing:1){
                
                Text(cpt.description)
                    .font(.subheadline)
                    .foregroundColor(cpt.color)
                    .fontWeight(.medium)
                
                Text(cpt.code)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                
                Text("\(cpt.rvu, specifier: "%.2f") RVUs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if mode == .edit {
                Button(action:{
                    presentCPTCodeEditScreen.toggle()
                }, label:{
                    Image(systemName: "info.circle").font(.title2).foregroundColor(.blue)
                }).buttonStyle(BorderlessButtonStyle())
                .sheet(isPresented: $presentCPTCodeEditScreen){
                    CPTCodeEditView(cptColor:.blue, cptCodeEditMode:.edit)
                }
            }else if mode == .select {
                Button(action:{}, label:{
                    Image(systemName:"circle").font(.title2).foregroundColor(.blue)
                }).buttonStyle(BorderlessButtonStyle())
            }
        }.padding(.vertical,1)
    }
}

struct CPTRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCPTRowView(cpt: cptList[0], mode: .edit)
    }
}
