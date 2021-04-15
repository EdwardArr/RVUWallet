//
//  PhysicianProfileView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/31/21.
//

import SwiftUI

struct PhysicianProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
//        ZStack{
//            Rectangle()
//                .foregroundColor(Color(UIColor.systemGroupedBackground))
//                .ignoresSafeArea()
        NavigationView{
        VStack{
                
                Form{
                    HStack{
                        Spacer()
                        VStack(alignment: .center, spacing:10){
                        ZStack {
                            Circle()
                                .frame(width:100,height: 100)
                                .foregroundColor(.gray)
                            Text("MB")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .bold()
                        }
                        Text("Mike Blaney").font(.title).bold()
                            
                    }
                        Spacer()
                    }.listRowBackground(Color(UIColor.systemGroupedBackground))
                    
                    Section{
                    NavigationLink(
                        destination: PersonalPhysicianDetails(),
                        label: {
                            Text("Personal Details")
                        })
                    }
                    Section(header:
                                Text("Favorites").foregroundColor(.primary).font(.title3).bold())
                    {
                        NavigationLink(
                            destination: FavoritesView(mode:.view)
                            ,label: {
                                Text("CPT Codes")
                            })
                    }
                    .textCase(nil)
                    
                    Section(header:Text("Privacy").foregroundColor(.primary).font(.title3).bold()){
                        Button(action: {
                            print("User pressed on export prcoedure data button")
                        }, label: {
                            Text("Export Procedure Data")
                        })
                    }.textCase(nil)
                
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                                    Button("Done", action: {
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

struct PhysicianProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicianProfileView()
    }
}
