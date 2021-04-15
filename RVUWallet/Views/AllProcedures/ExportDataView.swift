//
//  ExportDataView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/10/21.
//

import SwiftUI

struct ExportDataView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var fromDate: Date = Date()
    @State var toDate: Date = Date()
    
    var body: some View {
        NavigationView{
            ZStack(alignment:.bottom){
                
                Form{
                    Section(header:
                                Text("Select Dates")
//                                .foregroundColor(.primary)
//                                .font(.title2)
//                                .bold()
                                .textCase(nil)
                                .padding(.top,20)
                                ){
                        DatePicker("From", selection: $fromDate, displayedComponents: .date)
                        DatePicker("To", selection: $toDate, displayedComponents: .date)
                    }.textCase(nil)
                }
                //                    Rectangle()
                //                        .foregroundColor(.blue).ignoresSafeArea()
                Button(action: {}, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                        Text("Export 300 records").foregroundColor(.white).font(.headline)
                    }.frame(height:60).padding(.horizontal,20)
                })
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Export Data")
            .navigationBarItems(leading:
                                    Button("Done",
                                           action: {
                                        handleCancelTapped()
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

struct ExportDataView_Previews: PreviewProvider {
    static var previews: some View {
        ExportDataView()
    }
}
