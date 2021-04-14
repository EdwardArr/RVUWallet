//
//  AddPatientRowView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/7/21.
//

import SwiftUI

struct AddPatientRowView: View {
    
    @State private var patientName:String = ""
    @State private var addPatient = false
    @State private var isShowingTextScanner = false
    
    var body: some View {
        Section{
            
            if addPatient == true{
                HStack{
                    
                    Button(action:{
                        addPatient.toggle()
                    }, label:{
                       
                            Image(systemName: "minus.circle.fill").foregroundColor(.red).font(.title3)
                            
                        
                    })
                    
                
                    TextField("Name", text: $patientName).padding(.vertical,1)
                    
                    Spacer()
                    
                    Button(
                        action: {
                            print("User is using OCR to scan patinet name.")
                            self.isShowingTextScanner.toggle()
                            
                            
                        },
                        label: {
                            HStack{
                                Text("Scan Name").font(.system(size: 15))
                                Image(systemName: "doc.text.viewfinder").font(.system(size: 20))
                                
                            }
                        })
                }.padding(.vertical,1)
//                Divider()
//                TextField("Last Name", text: $patientName).padding(.vertical,1)
            }else{
            HStack{
            Button(action:{
                addPatient.toggle()
            }, label:{
                HStack{
                    Image(systemName: "plus.circle.fill").foregroundColor(.green).font(.title3)
                    Text("add patient name")
                }
            })
                Spacer()
            }
            
        }
        }
        .sheet(isPresented: $isShowingTextScanner, content: {
            TextScanner(delegate: TextScanner.Delegate(didClassify: { (patientName) in
                self.patientName = patientName
                
            }))
           
        })
    }
}

struct AddPatientRowView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientRowView()
    }
}
