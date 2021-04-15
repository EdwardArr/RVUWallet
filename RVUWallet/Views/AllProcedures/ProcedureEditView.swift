//
//  ProcedureEditView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI
import UniformTypeIdentifiers
import CodeScanner

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
//    @Binding var document: TextFile
    
    @State var hospitalRecord = ""
    @State var cpt = ""
    @State var cptDescription = ""
    @State var icd10 = ""
    @State var diagnosis = ""
    @State var rvu = ""
    @State var bgColor: Color
    @State var date: Date = Date()
    @State private var isShowingScanner = false
    @State private var patientName:String = ""
    @State private var addPatient = false
//    @State var clasificationIdentifier: String = ""
    @State private var isShowingTextScanner = false

    let names = ["Raju", "Ghanshyam", "Baburao Ganpatrao Apte", "Anuradha", "Kabira", "Chaman Jhinga", "Devi Prasad", "Khadak Singh"]
    
    var body: some View {
       
        NavigationView{
            
            
            List{
//                TextScanner(identifier: $patientName)
                
                
                
//                .padding(.vertical,1)
                
                Section {
                    HStack{
                        TextField("Hospital Code", text: $hospitalRecord)
                        Button(
                            action: {
                                print("User is scanning a barcode.")
                                self.isShowingScanner.toggle()
                                
                                
                            },
                            label: {
                                HStack{
                                    Text("Scan Barcode").font(.system(size: 15))
                                    Image(systemName: "barcode.viewfinder").font(.system(size: 20))
                                    
                                }
                            }).padding(.vertical,1)
                    }
                }
                .sheet(isPresented: $isShowingScanner, content: {
                    CodeScannerView(codeTypes: [.code39], simulatedData: "Edward Arribasplata\n770-298-9996", completion: self.handleScan)
                })
                
                Section{
                    DatePicker("Procedure Date", selection: $date, displayedComponents: .date)
                }
                
                Section(footer:Text("Button is disabled until app is HIPAA compliant.")){
                    AddPatientRowView().disabled(true)
                }
                
               
                
                
                
                Section{
                    
//                    Picker("CPT Code", selection: $cpt) {
//                        ForEach(cptList, id: \.self){
//                            $0
//                        }
//                    }
                    
                    NavigationLink(destination: SelectCPTView()
                    ){
                        HStack{
                            Text("CPT Code")
                            Spacer()
                            Text("\(self.cpt)")
                                .foregroundColor(.blue)
                        }
                    }.padding(.vertical,1)
//                    TextField("CPT Description", text: $cptDescription)
                }
                
//                Section{
//                    NavigationLink(
//                        destination: SearchICD10CodeView(text: $icd10, bgColor: bgColor))
//                    {
//                        HStack{
//                            Text("ICD-10 Code")
//                            Spacer()
//                            Text("\(self.icd10)")
//                                .foregroundColor(.blue)
//                        }
//
//                    }.padding(.vertical,1)
//                    TextField("ICD-10 Description", text: $diagnosis)
//                }
                
//                Section{
//                    HStack{
//                        Text("RVU")
//                        Divider()
//                        TextField("Amount", text:$rvu)
//                            .keyboardType(.decimalPad)
//                    }
//                }
        }
        .navigationBarTitle("New Procedure",displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {handleCancelTapped()}, label: {
                Text("Cancel").font(.body)
            }), trailing: Button(action: {handleCancelTapped()}, label: {
                Text("Save").font(.body)
            }).disabled(true)
        )
        .listStyle(GroupedListStyle())
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        self.isShowingScanner.toggle()
        
        switch result {
        case  .success(let code):
            let details = code.components(separatedBy: "\n")
            self.hospitalRecord = details[0]
            print(details[0])
            guard details.count == 2 else{ return}
            print(details[0])
            print("Scanned successfully")

        case .failure(let error):
            print("Scanning failed")
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
        ProcedureEditView(bgColor: .blue)
    }
}
