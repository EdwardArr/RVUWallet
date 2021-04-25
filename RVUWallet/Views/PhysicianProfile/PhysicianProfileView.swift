//
//  PhysicianProfileView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/31/21.
//

import SwiftUI
import Firebase

struct PhysicianProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var user_id = ""
    
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
                            
                            HStack(spacing:-1){
                                Text(userVM.user.first_name.prefix(1))
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .bold()
                                Text(userVM.user.last_name.prefix(1))
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .bold()
                            }
                        }
                            HStack(spacing:5){
                                Text(userVM.user.first_name)
                                    .font(.title)
                                    .bold()
                                Text(userVM.user.last_name)
                                    .font(.title)
                                    .bold()
                            }
                    }
                        Spacer()
                    }.listRowBackground(Color(UIColor.systemGroupedBackground))
                    
                    Section{
                    NavigationLink(
                        destination: PersonalPhysicianDetails(),
                        label: {
                            Text("Personal Details")
                                .font(.body)
                        })
                    }
                    Section(header:
                                Text("Favorites")
                                .foregroundColor(.primary)
                                .font(.title3)
                                .bold())
                    {
                        NavigationLink(
                            destination: FavoritesView(mode:.view)
                            ,label: {
                                Text("CPT Codes")
                                    .font(.body)
                            })
                    }
                    .textCase(nil)
                    
                    Section(header:Text("Privacy")
                                .foregroundColor(.primary)
                                .font(.title3)
                                .bold()){
                        NavigationLink("Privacy Policy", destination: Text("Privacy Policy"))
                        
                        Button(action: {
                            print("User pressed on export prcoedure data button")
                        }, label: {
                            Text("Export Procedure Data").font(.body)
                        }).disabled(true)
                    }.textCase(nil)
                    
                    Button(action: {
                        print("User pressed on sign out button")
                        self.presentationMode.wrappedValue.dismiss()
                        signOut()
                        
                    }, label: {
                        Text("Sign out")
                            .font(.body)
                    })
                    
                    
                    
                }
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        .onAppear(perform: {
            let userInfo = Auth.auth().currentUser
            self.user_id = userInfo?.uid ?? ""
            userVM.fetchUser(documentId: self.user_id)
        })
        .toolbar{
            ToolbarItem(placement:.principal){
                Text("")
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
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
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func signOut() {
        do {
          try Auth.auth().signOut()
            print("User signed out.")
            proceduresVM.unsubscribe()
            
        } catch {
          print("Sign out error")
        }
    }
}

struct PhysicianProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicianProfileView()
    }
}
