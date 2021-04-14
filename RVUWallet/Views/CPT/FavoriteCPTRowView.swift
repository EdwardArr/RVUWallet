//
//  CPTRowView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

struct FavoriteCPTRowView: View {
    
    var cpt:CPT
    
    var body: some View {
        VStack(alignment:.leading, spacing:5){
            
            Text(cpt.description)
                .font(.subheadline)
                .foregroundColor(cpt.color)
                .fontWeight(.medium)
            
            Text(cpt.code)
                .font(.title3)
                .foregroundColor(.primary)
                .fontWeight(.medium)
            
        }
//        .padding(.vertical,10)
    }
}

struct CPTRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCPTRowView(cpt: cptList[0])
    }
}
