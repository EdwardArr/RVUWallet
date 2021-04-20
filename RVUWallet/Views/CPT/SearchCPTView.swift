//
//  SearchCPTView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/14/21.
//

import SwiftUI

struct SearchCPTView: View {
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
                    TextField("Search CPT code", text:$text)
                        .foregroundColor(.blue)
                        .keyboardType(.numberPad)
                        .padding()
                }
                .frame(height:44)
                .padding([.horizontal,.top])
//                ColorPicker("Set code color", selection: $bgColor)
                
                RecentCPTCodesView().listStyle(GroupedListStyle())
                
            }
            .padding([.top])
            .navigationBarTitle("CPT Code")
//            .navigationBarItems(leading: Image(systemName: "chevron.left").foregroundColor(.blue))
        }
    }
}

//struct SearchCPTView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchCPTView(text: $text)
//    }
//}



//extension UIApplication {
//    func endEditing(_ force: Bool) {
//        self.windows
//            .filter{$0.isKeyWindow}
//            .first?
//            .endEditing(force)
//    }
//}
//struct ResignKeyboardOnDragGesture: ViewModifier {
//    var gesture = DragGesture().onChanged{_ in
//        UIApplication.shared.endEditing(true)
//    }
//    func body(content: Content) -> some View {
//        content.gesture(gesture)
//    }
//}
//extension View {
//    func resignKeyboardOnDragGesture() -> some View {
//        return modifier(ResignKeyboardOnDragGesture())
//    }
//}


//                Spacer()
                //            if self.text != "" {
                //
                //                ForEach(0..<locationsSelection.count) {
                //                    Text(locationsSelection[$0]).tag($0)
                //                }.resignKeyboardOnDragGesture()
                //
                //
                //            }else if self.text == "" {
                //
                //                ForEach(0..<locationsSelection.filter{$0.hasPrefix(text)}.count) {
                //                    Text(locationsSelection.filter{$0.hasPrefix(text)}[$0]).tag($0)
                //                }.resignKeyboardOnDragGesture()
                //
                //            }
