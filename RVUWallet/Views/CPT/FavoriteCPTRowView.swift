//
//  CPTRowView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

struct FavoriteCPTRowView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentCPTCodeEditScreen = false
    
    @StateObject var userVM = UserViewModel()
    
    @Binding var selected: CPT?
    
    @Binding var isSelected:Bool
    
    @State var showDelete = false
    
    var cpt:CPT
    
    var user:User
    
    var mode:FavoritesViewMode
    
    var body: some View {
        HStack{
            
            if mode == .edit {
                Button(action:{
                    showDelete.toggle()
                    
                }, label:{
                Image(systemName: "minus.circle.fill").font(.body).foregroundColor(.red)
                }).buttonStyle(BorderlessButtonStyle())
            }
            
            else if mode == .select {
                Button(action:{
                    
                    self.selected = cpt
                    self.isSelected = false
                    print("The selected bool is \(isSelected)")
                    
                    print("\(self.selected!.description) was selected.")
                    
                }, label:{
                    Image(systemName:
                            //                            self.selected!.code == cpt.code ? "largecircle.fill.circle":"circle"
                            checkedTheSelection()
                    )
                        .font(.title2)
                        .foregroundColor(.blue)
                }).buttonStyle(BorderlessButtonStyle())
            }
            
            VStack(alignment:.leading, spacing:1){
                
                Text(cpt.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
//                    .foregroundColor(cpt.color)
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
                    CPTCodeEditView(cptCodeEditMode:.edit, cpt: cpt)
                }
            }
            if showDelete{
                Button(action:{
                    userVM.deleteUserCPT(user, cpt: cpt)
                }, label:{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.red)
                        Text("Delete")
                            .foregroundColor(.white)
                    }
                })
            }
        }
        .padding(.vertical,1)
//        .onTapGesture {
//            self.selected = cpt
//        }
    }
    
    
    func checkedTheSelection() -> String {
        if self.selected?.code != nil{
            if self.selected!.code == cpt.code {
                return "checkmark.circle"
            }else{
                return "circle"
            }
//            return "largecircle.fill.circle"
        }else {
            return "circle"
            
        }
    }
}

//struct CPTRowView_Previews: PreviewProvider {
//    @State var selection:CPT?
//    
//    static var previews: some View {
//        FavoriteCPTRowView(selected: selection, cpt: cptList[0], mode: .edit)
//    }
//}
