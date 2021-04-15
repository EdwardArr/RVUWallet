//
//  DateListFilterView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/9/21.
//

import SwiftUI

struct DateListFilterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var dateFilters = ["This month", "This quarter","This year"]
    
    var body: some View {
        NavigationView{
            List{
                
                ForEach(dateFilters, id: \.self){ filter in
                    if filter == "This month"{
                        HStack{
                            Text(filter).foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                                .font(Font.body.weight(.medium))
                        }
                    }else{
                        Text(filter).foregroundColor(.primary)
                    }
                }
            }
            .padding(.top,20)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Filter")
            .navigationBarItems(leading:
                                    Button(action: {
                                            print("Filter Date Screen dismissed.",
                                                  handleCancelTapped()
                                            )}, label: {
                                                Text("Cancel").font(.body)
            }))
            
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct DateListFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DateListFilterView()
    }
}
