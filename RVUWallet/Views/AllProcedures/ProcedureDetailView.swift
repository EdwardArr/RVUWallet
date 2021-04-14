//
//  ProcedureDetailView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI


struct ProcedureDetailView: View {
    
    init() {
//        UIScrollView.appearance().backgroundColor = UIColor.clear
//        UITableView.appearance().separatorStyle = .none
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
//        UITableView.appearance().sectionHeaderHeight = .zero
    }
    
    var body: some View {
        
        
        VStack{
            List{
//                Section{
//                    HStack{
//                        Spacer()
//                        Text("14.98").font(.largeTitle).bold()
//                        Spacer()
//                    }
//                }.listRowBackground(Color(UIColor.systemGroupedBackground))
                Section{
                    VStack(alignment:.leading){
                        Text("Procedure date")
                            .font(.subheadline)

                        Text("March 16, 2021")
                            .font(.body)
                        
                    }.padding(.vertical,10)
                
                }
                VStack(alignment:.leading){
                    Text("CPT")
                        .font(.subheadline)
                    Text("34644")
                        .font(.body)
                }
                
                VStack(alignment:.leading){
                    Text("Description")
                        .font(.subheadline)
                        
                    Spacer()
                    Text("Lap Gastric Bypass")
                        .font(.body)
                }
                VStack(alignment:.leading){
                    
                    Text("RVU")
                        .font(.subheadline)
                       
                    Spacer()
                    Text("14.98")
                        .font(.body)
                       
                    
                }
                Section{
                    VStack(alignment:.leading){
                        Text("Photo")
                            .font(.subheadline)
                        
                    }
                }
            }
        }
//        .background(Color.blue)
        .listRowBackground(Color.red)
        .navigationBarTitle("", displayMode:.inline)
        .navigationBarItems(trailing: Button(action: {
            print("Editing procedure")
        }, label: {
            Text("Edit").font(.body)
        }))
        .listStyle(InsetGroupedListStyle())
        
        
    }
}

struct ProcedureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureDetailView()
    }
}
