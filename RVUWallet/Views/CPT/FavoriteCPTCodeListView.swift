//
//  FavoriteCPTCodeListView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/1/21.
//

import SwiftUI

struct FavoriteCPTCodeListView: View {
    @State var text = ""
    @State var isEditing = false
    var body: some View {

//        List{
            
//            Section{
//                HStack{
//                    Button(action{},label:{""})
//                }
//            }
            
//            Section(header:Text("Favorites")){
            ForEach(cptList) {cpt in
                HStack{
                    if isEditing == true {
                    Image(systemName: "minus.circle.fill").font(.title2).foregroundColor(.red)
                    }
//                    HStack {
//                        Image(systemName:"star.square.fill").foregroundColor(cpt.color).font(.title)
//                    }
                    FavoriteCPTRowView(cpt: cpt)
                    
                    
                    Spacer()
                    if isEditing == true{
                        Image(systemName: "info.circle").font(.title2).foregroundColor(.blue)
                    }
                }.padding(.vertical,5)
            }
//        }
//        }
        
                                    
    }
}

struct FavoriteCPTCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCPTCodeListView()
    }
}
