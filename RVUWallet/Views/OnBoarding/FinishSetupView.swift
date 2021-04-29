//
//  FinishSetupView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/23/21.
//

import SwiftUI
import Firebase

struct FinishSetupView: View {
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var user_id = ""
    @State var revenue_per_rvu = ""
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Get More From RVU Wallet")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.bottom,-1)
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                VStack(alignment:.leading){
                    
                    HStack{
                        Spacer()
                        Button {
                            // Toggle isHidden variable here and
                            // save to user defaults
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(UIColor.systemGray))
                        }
                    }
                    Spacer()
                    Text("Enter Revenue per RVU")
                        .font(.title2)
                        .bold()
                    
                    Text("Dollar amount is used to calculate total revenue earned.")
                        .font(.body)
                        .padding(.bottom)
                    HStack(spacing:1){
                        Text("$")
                            .font(.system(size: 40))
                        TextField("0.00", text: $userVM.user.revenue_per_rvu)
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .keyboardType(.decimalPad)
                    }
                    Button( action: {
                        saveRevenuePerRVU()
                    }, label: {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 12.0)
                            Text("Save").foregroundColor(.white)
                        }
                        .frame(height:44)
                    }).disabled(areVariableEmpty())
                }.padding()
            }
        }
        .onAppear( perform:{
                    let userInfo = Auth.auth().currentUser
                    self.user_id = userInfo?.uid ?? ""
                    print("fetching user info for on boarding views")
                    userVM.fetchUser(documentId:user_id)})
    }
    
    func saveRevenuePerRVU() {
        userVM.save()
    }
    
    func areVariableEmpty()-> Bool{
        if userVM.user.revenue_per_rvu == ""{
            return true
        }
        else{
            return false
        }
    }
    
}

struct FinishSetupView_Previews: PreviewProvider {
    static var previews: some View {
        FinishSetupView()
    }
}
