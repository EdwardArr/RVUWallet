//
//  RecentICD10CodesView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct RecentICD10CodesView: View {
    var body: some View {
        List{
            
            Section(header:Text("Recent ICD-10 Codes")){
                
                ForEach(proceduresList){ procedure in
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(8.0)
                        HStack(alignment:.center){
                            
                            VStack(alignment:.leading){
//                                Text("\(procedure.icd10)")
//                                    .foregroundColor(.primary)
//                                    .font(.headline)
                                Text("\(procedure.hospital_barcode)")
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
        }.listStyle(InsetGroupedListStyle())
    }
}

struct RecentICD10CodesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentICD10CodesView()
    }
}
