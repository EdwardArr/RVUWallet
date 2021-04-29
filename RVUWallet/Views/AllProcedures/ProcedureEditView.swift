//
//  ProcedureEditView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI
import UniformTypeIdentifiers
import CodeScanner
import Firebase

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

enum ProcedureViewMode {
  case new, edit
}

struct ProcedureEditView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var procedureVM = ProcedureViewModel()
    
    @ObservedObject var physicianVM = PhysicianViewModel()

    @State var barcode = ""
    @State var cpt = ""
    @State var date: Date = Date()
    
    @State var selection: CPT? = CPT(id: "", code: "", description: "", rvu: 0.0)
    
    var mode: ProcedureViewMode = .new
    
    @State var physician:Physician = Physician(id: "dTsn2jWAdrtAMj4N1zYn", first_name: "Michael", last_name: "Blaney", phone_number: "+1(706)285-3186", email: "mike.blaney@bcofa.com", revenue_per_rvu: 54.19, favorite_cpts: [], procedures: [])
    
    @State private var isShowingScanner = false
    @State private var patientName:String = ""
    @State private var addPatient = false
    @State private var isShowingTextScanner = false
    
    @State var showCPTList:Bool = false
    
    @State var user_id = ""
    
    var body: some View {
       
        NavigationView{
            
            
            List{
//                TextScanner(identifier: $patientName)
                Section {
                    HStack{
                        TextField("Hospital Code", text: $procedureVM.procedure.hospital_barcode)
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
                }.textCase(nil)
                .sheet(isPresented: $isShowingScanner, content: {
                    CodeScannerView(codeTypes: [.code39], simulatedData: "Edward Arribasplata\n770-298-9996", completion: self.handleScan)
                })
                
                Section{
                    DatePicker("Procedure Date", selection: $date, displayedComponents: .date)
                }.textCase(nil)
                
                Section(footer:Text("Button is disabled until app is HIPAA compliant.")){
                    AddPatientRowView().disabled(true)
                }.textCase(nil)
            
                Section{
                    
                    NavigationLink(destination: SelectCPTView(isSelected:$showCPTList, selection:$selection), isActive:$showCPTList){
                        HStack{
                            Text("CPT Code")
                            Spacer()
                            Text("\(self.selection?.code ?? "")")
                                .foregroundColor(.blue)
                        }
                    }
                    .isDetailLink(false)
                    .padding(.vertical,1)
                    
                    if self.selection?.description != nil && self.selection?.description != ""{
                        Text(self.selection?.description ?? "")
                    }
                    if self.selection?.rvu != nil && self.selection?.rvu != 0.0 {
                        Text("\(self.selection?.rvu ?? 0.0, specifier: "%.2f")")
                    }
                    
                }.textCase(nil)
            }
            
            .navigationBarTitle(mode == .new ? "New Procedure" : procedureVM.procedure.hospital_barcode)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: Button(action: {handleCancelTapped()}, label: {
                    Text("Cancel").font(.body)
                }), trailing: Button(action: {
                    handleDoneTapped()
                    dismiss()
                    
                }, label: {
                    Text(mode == .new ? "Save" : "Done").font(.body)
                }).disabled(areVariablesEmpty())
            )
            .listStyle(GroupedListStyle())
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        self.isShowingScanner.toggle()
        
        switch result {
        case  .success(let code):
            let details = code.components(separatedBy: "\n")
            self.procedureVM.procedure.hospital_barcode = details[0]
            print(details[0])
            guard details.count == 2 else{ return}
            print(details[0])
            print("Scanned successfully")

        case .failure(let error):
            print("Scanning failed")
        }
    }
    
    func handleDoneTapped() {
        
        let userInfo = Auth.auth().currentUser
        self.user_id = userInfo?.uid ?? ""
        
        let id = UUID().uuidString
        
        if procedureVM.procedure.id == ""{
            procedureVM.procedure.id = id
        }
        
        procedureVM.procedure.cpt_code = self.selection?.code ?? ""
        procedureVM.procedure.cpt_rvu = self.selection?.rvu ?? 0.0
        procedureVM.procedure.procedure_date = date.timeIntervalSince1970
        procedureVM.procedure.cpt_id = self.selection?.id ?? ""
        procedureVM.procedure.cpt_description = self.selection?.description ?? ""
        procedureVM.procedure.primary_md = self.user_id
        procedureVM.save()
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    func areVariablesEmpty() -> Bool {
        if procedureVM.procedure.hospital_barcode != "" && self.selection?.code != "" {
            return false
        }else{
            return true
        }
    }
    
    func isItTrue() -> Bool {
        if showCPTList == false {
            print("Edit procedure page should be in view.")
            return false
        }else{
            print("CPT list page should be in view.")
            return true
        }
    }
}

//struct ProcedureEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProcedureEditView(selection: cptList[0])
//    }
//}
