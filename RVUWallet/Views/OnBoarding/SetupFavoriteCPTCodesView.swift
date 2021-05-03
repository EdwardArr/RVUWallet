//
//  FavoriteCPTCodes.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 5/1/21.
//

import SwiftUI

struct SetupFavoriteCPTCodesView: View {
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                VStack(alignment:.leading){
                    HStack{
                        Spacer()
                        Button {
                            // Toggle isHidden variable here and
                            // save to user defaults
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(UIColor.systemGray))
                        }
                    }
                    
                    HStack(alignment:.center){
                        Spacer()
                        ZStack{
                            Circle()
                                .frame(square: 120)
                                .foregroundColor(Color(UIColor.systemGray6))
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 60))
                            
                        }
                        Spacer()
                    }.padding([.top,.bottom],5)
                    
                    VStack(alignment:.leading, spacing:5){
                        Text("Favorite CPT Codes")
                            .font(.title2)
                            .bold()
                        
                        Text("Add CPT codes to your Favorites List for quicker selection when entering procedures.")
                            .font(.body)
                        
                        Button( action: {
                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12.0)
                                Text("Add CPT Codes")
                                    .foregroundColor(.white)
                            }
                            .frame(height:44)
                        }).padding(.top)
                    }
                }.padding()
            }
        }
    }
}

struct FavoriteCPTCodes_Previews: PreviewProvider {
    static var previews: some View {
        SetupFavoriteCPTCodesView()
    }
}
