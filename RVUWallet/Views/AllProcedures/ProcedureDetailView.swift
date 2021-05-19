//
//  ProcedureDetailView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI


struct ProcedureDetailView: View {
    
    @State private var presentEditProcedureScreen = false
    
    @State var selection: CPT?
    
    var procedure:Procedure
    
    var cpt:CPT
    
    var body: some View {

        VStack{
            List{
                Section{
                    VStack(alignment:.leading, spacing:1){
                        Text("Hospital Code")
                            .font(.subheadline)
                        Text(procedure.hospital_barcode)
                            .font(.body)
                            .fontWeight(.medium)
                    }.padding(.vertical,10)
                }
                
                Section{
                    VStack(alignment:.leading, spacing:1){
                        Text("Procedure Date")
                            .font(.subheadline)

                        Text("\(Date(timeIntervalSince1970: procedure.procedure_date ),style: .date)")
                            .font(.body)
                            .fontWeight(.medium)
                        
                    }.padding(.vertical,10)
                }
                
                VStack(alignment:.leading, spacing:1){
                    Text("CPT Code")
                        .font(.subheadline)
                    Text(procedure.cpt_code)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                VStack(alignment:.leading, spacing:1){
                    Text("Description")
                        .font(.subheadline)
                    Text(procedure.cpt_description)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                VStack(alignment:.leading, spacing:1){
                    Text("RVU")
                        .font(.subheadline)
                    Text("\(procedure.cpt_rvu, specifier: "%.2f")")
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
        }
        .listRowBackground(Color.red)
        .navigationBarTitle(procedure.hospital_barcode, displayMode:.large)
        .navigationBarLargeTitleItems(trailing: Text(""))
        .navigationBarItems(trailing: Button(action: {
            print("Editing procedure")
            presentEditProcedureScreen.toggle()

        }, label: {
            Text("Edit").font(.body)
        }))
        .listStyle(InsetGroupedListStyle())

        .sheet(isPresented: $presentEditProcedureScreen){
            ProcedureEditView(procedureVM: ProcedureViewModel(procedure: procedure), date: Date(timeIntervalSince1970:procedure.procedure_date), selection: CPT(id: procedure.cpt_id, code: procedure.cpt_code, description: procedure.cpt_description, rvu: procedure.cpt_rvu),mode: .edit)
        }  

    }
}

struct ProcedureDetailView_Previews: PreviewProvider {
    static var previews: some View {

        ProcedureDetailView(procedure: proceduresList[0], cpt: cptList[0])

    }
}
