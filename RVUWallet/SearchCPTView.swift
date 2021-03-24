//
//  SearchCPTView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/14/21.
//

import SwiftUI

struct SearchCPTView: View {
    @Binding var text : String
    @State var locationsSelection: [String] = ["43644", "43675"]//Your Array
    @State var locationSelection: Int = 0
    
    var body: some View {
        List{
            TextField("Search CPT code", text:$text)
                .keyboardType(.numberPad)
            if self.text != "" {
                
                ForEach(0..<locationsSelection.count) {
                    Text(locationsSelection[$0]).tag($0)
                }.resignKeyboardOnDragGesture()
                
                
            }else if self.text == "" {
                
                ForEach(0..<locationsSelection.filter{$0.hasPrefix(text)}.count) {
                    Text(locationsSelection.filter{$0.hasPrefix(text)}[$0]).tag($0)
                }.resignKeyboardOnDragGesture()
                
            }
        }.listStyle(GroupedListStyle())
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

//struct SearchCPTView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchCPTView(text: $text)
//    }
//}
