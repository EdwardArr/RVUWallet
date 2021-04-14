//
//  SummaryView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI
import SwiftUIPlus

struct SummaryView: View {
    
    @State var stats = ["revenue":50000,"RVU":2300]
    @State var isFilterButtonHidden:Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("April 2021")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .bold()
                Spacer()
//                Text("Change date")
//                    .foregroundColor(.blue)
//                    .isHidden(isFilterButtonHidden)
            }.padding(.bottom,-1)
            HStack(){
//            ForEach(0..<stats.keys.count){stat in
                ZStack{
                    Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
                    HStack{
                    VStack(alignment:.leading){
                        Text("Total RVUs")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text(" 2,832.19")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                        Text("$153,476.38")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                    }.padding(.leading)
                        Spacer()
                    }
                }.frame(height:85)
                
                ZStack{
                    Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
                    HStack{
                    VStack(alignment:.leading){
                        Text("Performed")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        HStack(alignment:.firstTextBaseline, spacing:5){
                        Text("80")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            Text("Procedures")
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
//                        Text("See all data").font(.subheadline).foregroundColor(.blue)
                    }.padding(.leading)
                        Spacer()
                    }
                }.frame(height:85)
                
              Spacer()
//            }
            }
        }
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
        SummaryView(isFilterButtonHidden: false)
            .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea(.all)
    }
}
