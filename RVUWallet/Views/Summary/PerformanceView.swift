//
//  PerformanceView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 5/3/21.
//

import SwiftUI

struct PerformanceView: View {
    
    @State var picker = 0
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                if picker == 0{
                    Text("May 2021")
                        .font(.largeTitle)
                        .bold()
                }else if picker == 1{
                    Text("April - June 2021")
                        .font(.largeTitle)
                }else{
                    Text("Year 2021")
                        .font(.largeTitle)
                }
                    Spacer()
            }
                
            }
        }
        .largeNavigationBar(titleView: Text("Hello"), leadingView: EmptyView(), trailingView: EmptyView(), backgroundView: Text("World"), showsDivider: false, transparentNavBarHeight: 0)
        .toolbar{
            ToolbarItem(placement:.principal){

                Picker(selection: $picker, label: Text("What is your favorite color?")) {
                    Text("Year")
                        .tag(2)
                    Text("Quarter")
                        .tag(1)
                    Text("Month")
                        .tag(0)
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView()
    }
}
