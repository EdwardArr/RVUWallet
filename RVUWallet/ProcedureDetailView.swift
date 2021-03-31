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
                Section{
                    HStack{
                        Spacer()
                        Text("14.98").font(.largeTitle).bold()
                        Spacer()
                    }
                }.listRowBackground(Color(UIColor.systemGroupedBackground))
                Section{
                    VStack(alignment:.leading){
                        Text("Procedure date")
                            .font(.callout)

                        Text("March 16, 2021")
                            .font(.title3)
                        
                    }.padding(.vertical,10)
                
                }
                VStack(alignment:.leading){
                    Text("CPT")
                        .font(.callout)
                    Text("34644")
                        .font(.title3)
                }
                
                VStack(alignment:.leading){
                    Text("Description")
                        .font(.callout)
                        
                    Spacer()
                    Text("Lap Gastric Bypass")
                        .font(.title3)
                }
                VStack(alignment:.leading){
                    
                    Text("RVU")
                        .font(.callout)
                       
                    Spacer()
                    Text("14.98")
                        .font(.title3)
                       
                    
                }
                Section{
                    VStack(alignment:.leading){
                        Text("Photo")
                            .font(.callout)
                        
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
        .onAppear(perform: {
            UITableView.appearance().sectionHeaderHeight = .zero
        })
        
    }
}

struct ProcedureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureDetailView()
    }
}
