//
//  FavoriteICD10CodesList.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct FavoriteICD10CodesList: View {
    var body: some View {
        List{
            ForEach(cptList) {cpt in
                VStack(alignment:.leading){
                    Text(cpt.code).font(.headline)
                    Text(cpt.description)
                        .font(.subheadline)
//                        .foregroundColor(cpt.color)
                }.padding(.vertical,10)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Favorite ICD-10 Codes", displayMode: .inline)
        .navigationBarItems(trailing: Image(systemName: "plus"))
    }
}

struct FavoriteICD10CodesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteICD10CodesList()
    }
}
