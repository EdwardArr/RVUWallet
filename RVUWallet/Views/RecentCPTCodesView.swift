//
//  RecentCPTCodes.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct RecentCPTCodesView: View {
    var body: some View {

            List{
                
                Section(header:Text("Recent CPT Codes")){
                    
                    ForEach(cptList){ cpt in
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(8.0)
                            HStack(alignment:.center){
                                
                                VStack(alignment:.leading){
                                    Text("\(cpt.code)")
                                        .foregroundColor(.primary)
                                        .font(.headline)
                                    Text("\(cpt.description)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Image(systemName: "circle")
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(height:44)
                        .padding(.vertical, 1)
                    }
                    
                }
            }
//            .listStyle(InsetGroupedListStyle())
    }
}

struct RecentCPTCodes_Previews: PreviewProvider {
    static var previews: some View {
        RecentCPTCodesView()
    }
}
