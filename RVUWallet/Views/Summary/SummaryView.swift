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
            GeometryReader{ geometry in
                HStack(){
                    ZStack(alignment:.center){
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                        //                            .cornerRadius(8)
                        HStack{
                            VStack(alignment:.leading){
                                Text("Total RVUs")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Text("\(totalRVU, specifier: "%.2f")")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Text("$\(revenuePerRVU*totalRVU, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .fontWeight(.medium)
                            }.padding(.leading)
                            Spacer()
                        }
                    }
                    .frame(width:geometry.size.width
                            * 0.475, height:85)
                    
                    Spacer()
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                        HStack{
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
                            .padding(.leading)
                            Spacer()
                        }
                    }
                    .frame(width:geometry.size.width * 0.475, height:85)
                }
            }
            
        }.frame(height:85)
    }
}

struct TotalStatsView: View{
    var body: some View {
        VStack{
            HStack{
                Text("Summary")
                    .font(.title2)
                    .bold()
                Spacer()
                Text("January 21 - April 21, 2021").foregroundColor(.blue)
            }.padding(.bottom,-1)
        ZStack{
            Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
            HStack(alignment: .top){
//                Spacer()
                
                
                VStack(alignment:.leading, spacing:0){
                    Text("Procedures")
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                    Text("80")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
                }
                
                Divider().padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
            
                VStack(alignment:.leading, spacing:0){

                    Text("RVUs")
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Text("2032.18")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                
                Divider().padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
            
                VStack(alignment:.leading, spacing:0){

                    Text("Revenue")
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Text("$50,032.18")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                
                Spacer()
//                Text("104.18").font(.title2).foregroundColor(.primary).bold().padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }.frame(height:65)
        }.padding([.horizontal],20)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(proceduresList: proceduresList, totalRVU: 201.35, revenuePerRVU: 54.19)
            .padding()
            .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea(.all)
    }
}
