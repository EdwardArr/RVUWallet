//
//  PersonalPhysicianDetails.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/6/21.
//

import SwiftUI
import Firebase

enum personalDetailsMode {
    case view, edit
}

struct PersonalPhysicianDetails: View {
    
    @State var mode:personalDetailsMode = .view
    
//    @ObservedObject var physicianVM = PhysicianViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var user_id = ""
    
    var isBackButtonHidden: Bool {
        switch(self.mode) {
        case .edit:
            return true
        case .view:
                return false
            }
    }
    
    var leadingNavItem: some View {
        switch(self.mode) {
        case .edit:
            return Text("Cancel")
        case .view:
                return Text("")
        }
    }
    
    var trailingNavItem: some View {
        switch(self.mode) {
        case .edit:
            return AnyView(Text("Done"))
        case .view:
                return AnyView(Text("Edit"))
        }
    }
    
    var body: some View {
        List{
            Section{
                HStack{
                    Spacer()
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
                }.padding(.vertical,30)
                    Spacer()
                }
                
                PhysicianPersonalDetailRow(descriptor:"First Name", personalInfo:$userVM.user.first_name, keyboardType: .emailAddress, mode:mode).font(.body)
                PhysicianPersonalDetailRow(descriptor:"Last Name", personalInfo:$userVM.user.last_name, keyboardType: .emailAddress, mode:mode).font(.body)
                PhysicianPersonalDetailRow(descriptor:"Email", personalInfo:$userVM.user.email, keyboardType: .emailAddress, mode:mode).font(.body)
            
            }
            
            Section(footer:Text("Revenue is used to calculate total revenue in Summary page.")){
                
                // Future -- convert back revenue_per_rvu from User back to Double type
                // using String because it is easy to bind to textfield
                PhysicianPersonalDetailRow(descriptor:"Revenue per RVU", personalInfo: $userVM.user.revenue_per_rvu, keyboardType: .decimalPad, mode:mode).font(.body)
        
            }
        }
        .offset(y:-40)
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Personal Details"), displayMode: .inline)
        .navigationBarBackButtonHidden(isBackButtonHidden)
        .navigationBarItems(leading:
                                Button(action: {
                                    mode = .view
                                }, label: {
                                    leadingNavItem.font(.body)
                                })
                                
                                ,trailing:
                                Button(action: {
                                    if mode == .edit{
                                        handleDoneTapped()
                                        mode = .view
                                    }else if mode == .view{
                                    mode = .edit
                                    }
                                }, label: {
                                    trailingNavItem.font(.body)
                                }))
        .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea()
        .onAppear {
            let userInfo = Auth.auth().currentUser
//            self.email = userInfo?.email ?? ""
            self.user_id = userInfo?.uid ?? ""
//            let id = userVM.id
            userVM.fetchUser(documentId: self.user_id)
        }
        
    }
    
    func handleDoneTapped(){
        userVM.save()
    }
}

struct PersonalPhysicianDetails_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPhysicianDetails(mode: .view)
    }
}
