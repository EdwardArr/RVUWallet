//
//  PerformanceView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 5/3/21.
//

import SwiftUI

enum date_selected{
    case month, quarter, year
}

extension UIToolbar {
    var month: UIToolbar {
        return UIToolbar.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}

struct PerformanceView: View {
    
    @State var picker = 0
    
    var dateSelected: String{
        if picker == 0{
            return "May 2021"
        }else if picker == 1{
            return ("\(Date.getThisQuarter(Date())())")
        }else{
            return ("Year \(Date.getThisYear(Date())())")
        }
    }
    
    var body: some View {
        
        ZStack(alignment:.bottom){
            ScrollView(.vertical, showsIndicators: false){
                PerformanceGraph()
            }
        }
        
        .navigationBarTitle(dateSelected, displayMode: .large)
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
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct PerformanceGraph: View {
    
    var body: some View{
       
        ZStack(alignment:.topLeading){
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
            HStack{
            VStack(alignment: .leading){
                Text("Total RVUs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("$2,000.00")
                    .font(.title)
                    .foregroundColor(.primary)
                    .bold()
            }
                Spacer()
            }.padding()
        }.padding([.horizontal])
//        .frame(width:200, height:60)
    }
}

struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView()
    }
}
