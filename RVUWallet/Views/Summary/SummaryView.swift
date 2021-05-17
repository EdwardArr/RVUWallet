//
//  SummaryView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI
import SwiftUIPlus

struct SummaryView: View {
    
    var proceduresList:[Procedure]
    
    var totalRVU:Double
    
    var revenuePerRVU:Double
    
    var body: some View {
        
        VStack{
            HStack{
                Text(currentMonth())
                    .foregroundColor(.primary)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}, label: {
                    NavigationLink(
                        destination:
                            PerformanceView()
                        ,
                        label: {
                            Text("Show More")
                        }
                    )
                })
                
            }
            .padding(.bottom,-1)
            VStack{
            GeometryReader{ geometry in
                
                HStack(){
                    
                    ZStack(alignment: .leading){
                        
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                            .frame(width:geometry.size.width * 0.475, height:85)
                        HStack{
                            
                            VStack(alignment:.leading){
                                Text("Total RVUs")
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                Text("\(totalRVU, specifier: "%.2f")")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Text("$\(revenuePerRVU*totalRVU, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .fontWeight(.medium)
                            }
                            .padding([.leading,.vertical])
                            
                            Spacer()
                        }
                    }
                    
                    
                    Spacer()
                    
                    ZStack(alignment:.leading){
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                            .frame(width:geometry.size.width * 0.475, height:85)
//                            .fixedSize(horizontal: true, vertical: false)
                        
                            VStack(alignment:.leading){
                                Text("Performed")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                HStack(alignment:.firstTextBaseline, spacing:5){
                                    Text("\(proceduresList.count)")
                                        .font(.largeTitle)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    Text("Procedures")
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding([.leading,.vertical])
                    }
                    
                }
            }
            }
        }
        .frame(height:115)
        .textCase(nil)
    }
    
    func currentMonth()->String{
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: now)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(proceduresList: proceduresList, totalRVU: 201.35, revenuePerRVU: 54.19)
            .padding()
            .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea(.all)
    }
}
