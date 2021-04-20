//
//  SearchICD10CodeView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct SearchICD10CodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var text : String
    @State var locationsSelection: [String] = ["43644", "43675"]//Your Array
    @State var locationSelection: Int = 0
//    @State var bgColor: Color = Color(red: .random(in: 0...1), green:  .random(in: 0...1), blue:  .random(in: 0...1))
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(UIColor.systemGroupedBackground))
                .ignoresSafeArea()
            VStack(spacing:20){
                ZStack{
                    Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
                    TextField("Search ICD-10 code", text:$text)
                        .foregroundColor(.blue)
                        .padding()
                }
                .frame(height:44)
                .padding([.horizontal,.top])
//                ColorPicker("Set code color", selection: $bgColor)
                
                RecentICD10CodesView()
                
            }
            .padding([.top])
            .navigationBarTitle("ICD-10 Code")
//            .navigationBarItems(leading: Image(systemName: "chevron.left").foregroundColor(.blue))
        }
    }
}

//struct SearchICD10CodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchICD10CodeView(text: "Hello")
//    }
//}
