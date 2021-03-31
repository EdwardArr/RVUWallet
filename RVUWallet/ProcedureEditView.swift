//
//  ProcedureEditView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct TextFile: FileDocument {
    
    
    static var readableContentTypes = [UTType.pdf]
    
    var text = ""
    
    init(configuration: ReadConfiguration) throws {
            if let data = configuration.file.regularFileContents {
                text = String(decoding: data, as: UTF8.self)
            }
        }

        func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
            let data = Data(text.utf8)
            return FileWrapper(regularFileWithContents: data)
        }
    
    init(initialText: String = "") {
        text = initialText
    }
    
    init(fileWrapper: FileWrapper, contentType: UTType) throws {
        if let data = fileWrapper.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }
    
    func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
        let data = Data(text.utf8)
        fileWrapper = FileWrapper(regularFileWithContents: data)
    }
}

struct ProcedureEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var document: TextFile
    
    @State var cpt = ""
    @State var idc = ""
    @State var date: Date = Date()
    let names = ["Raju", "Ghanshyam", "Baburao Ganpatrao Apte", "Anuradha", "Kabira", "Chaman Jhinga", "Devi Prasad", "Khadak Singh"]
    
    var body: some View {
        NavigationView{
            List{
                Section{
                DatePicker("Procedure date", selection: $date, displayedComponents: .date)
                }
                .padding(.vertical,1)
                
                Section{
                NavigationLink(destination: SearchCPTView(text: $cpt)){
                    HStack{
                        Text("CPT")
                        Spacer()
                        Text("\(self.cpt)")
                    }
                }.padding(.vertical,1)
                }
                
                NavigationLink(destination: SearchCPTView(text: $cpt)){
                    HStack{
                        Text("ICD-10")
                        Spacer()
                        Text("\(self.cpt)")
                    }
                }.padding(.vertical,1)
    
            Section {
                Button(
                    action: {
                        print("User is taking an image of an incident.")
//                        self.showImagePicker = true
//                        self.sheetState = .selectPhotos
//                                self.isShowingSheet = true
                        
                    },
                    label: {
                        HStack{
                            Image(systemName: "doc.circle.fill").font(.system(size: 20))
                            Text("Add document").font(.system(size: 15))
                        }
                    }).padding(.vertical,1)
            }
                
        }
        .navigationBarTitle("New Procedure",displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {handleCancelTapped()}, label: {
                Text("Cancel").font(.body)
            }), trailing: Button(action: {handleCancelTapped()}, label: {
                Text("Save").font(.body)
            })
        )
        .listStyle(GroupedListStyle())
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct ProcedureEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureEditView(document: .constant(TextFile()))
    }
}
