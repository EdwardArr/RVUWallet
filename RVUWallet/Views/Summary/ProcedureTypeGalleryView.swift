//
//  ProcedureTypeGalleryView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct ProcedureTypeGalleryView: View {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        VStack{
            HStack{
                Text("Most RVUs per Procedures")
                    .font(.title2)
                    .bold()
                Spacer()
                
            }.padding(.horizontal,20)
            LazyVGrid(columns: columns, spacing:5) {
                ForEach(cptList){procedure in
                    NavigationLink(
                        destination:
                            ScrollView{
                                HStack{
                                    Text(procedure.description)
//                                    .foregroundColor(procedure.color)
                                .font(.largeTitle)
                                    Spacer()
                                }
                            }
//                            .padding(.horizontal)
                        ,
                        label: {
                            SingleStat(width: 140, procedure: procedure)
                        })
                }.padding(.all, 10)
            }

           NavigationLink(
            destination:
//                ProcedureListView(proceduresList: <#[Procedure]#>)
            Text("Hello World")
            ,
            label: {
                SeeAllProcedureDataButton()
            })
        }
    }
}

struct ProcedureTypeHGridView: View {
    @State var filterTopProceduresBy = false
    let rows = [GridItem(.adaptive(minimum: 70)),GridItem(.adaptive(minimum: 70)),GridItem(.adaptive(minimum: 50))]
//    let rows: [GridItem] = Array(repeating: .init(.adaptive(minimum: 150)), count: 3)
    
    var body: some View {
        VStack{
            HStack{
                Text("Your Top Procedures")
                    .font(.title2)
                    .bold()
                Spacer()
//                Button(action: {
//                    print("User filtered top procedures ")
//                }, label: {
//                    Text("Show More")
//                })
                
            }.padding(EdgeInsets(top: 0, leading: 20, bottom: -1, trailing: 20))
            GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false){
             
                LazyHGrid(rows: rows, spacing: 10) {
                    ForEach(cptList.sorted{$0.rvu > $1.rvu}){procedure in
//                        NavigationLink(
//                            destination:
//                                HStack{
//                                    Text(procedure.description)
//                                        .foregroundColor(procedure.color)
//                                        .font(.title)
//                                        .fontWeight(.medium)
//                                    Spacer()
//                                }
//                            ,label: {
                                
                                SingleStat(
//                                    width:150, procedure: procedure
                                    width: geometry.size.width * 0.50 - 25, procedure: procedure
                                )
                                    
                                    
//                            })
//                            .frame(maxWidth: geometry.size.width * 0.50)
                    }
                }
                
                .padding(.horizontal, 20)
            
            }
            }.frame(height:230)
        }
    }
}



struct SingleStat: View {
    
    var width:CGFloat
    var procedure: CPT
    
    var body: some View {
        
        
        ZStack {
            Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
            HStack(alignment: .center, spacing:1){
//                Image(systemName: "1.circle").foregroundColor(procedure.color)
                VStack(alignment:.leading, spacing:1){
//                    Image(systemName: "plus").padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
//                    Spacer()
                    Text(procedure.description)
                        .font(.subheadline)
                        .fontWeight(.medium)
//                        .foregroundColor(procedure.color)
                        //                        .foregroundColor(procedure.color)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    HStack(alignment:.lastTextBaseline, spacing:1){
                        Text("\(procedure.rvu, specifier: "%.2f") RVUs")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            //                        .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
//                        Text(" RVUs")
//                            .font(.title3)
//                            .fontWeight(.medium)
//                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
            }.padding(.leading,10)
        }.frame(width:width, height: 70)
    }
}

struct SeeAllProcedureDataButton: View{
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
            HStack{
                Text("See All Procedure Data")
            
                Spacer()
            }.padding(.leading)
        }
        .padding(.horizontal,20)
        .frame(height:44)
    }
}

struct ProcedureTypeGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureTypeHGridView()
            .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea(.all)
    }
}
