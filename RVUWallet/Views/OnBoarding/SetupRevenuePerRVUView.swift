//
//  SetupRevenuePerRVUView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 5/1/21.
//

import SwiftUI
import Firebase

struct SetupRevenuePerRVUView: View {
    
    @StateObject var userVM = UserViewModel()
    
    @State var user_id = ""
    @State var revenue_per_rvu = ""
    
    var body: some View {
        VStack{
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
                
                HStack(alignment:.center){
                    Spacer()
                    ZStack{
                        Circle()
                            .frame(square: 120)
                            .foregroundColor(Color(UIColor.systemGray6))
                        Image(systemName: "dollarsign.circle")
                            .foregroundColor(.green)
                            .font(.system(size: 120))
                        Circle()
                            //                                .trim(from: 0, to: 0.7)
                            .stroke(Color(UIColor.systemGray6), lineWidth: 25)
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }.padding([.top,.bottom],5)
                
                VStack(alignment:.leading, spacing:5){
                    Text("Enter Dollar Converison Factor")
                        .font(.title2)
                        .bold()
                    
                    Text("Dollar amount is used to calculate total revenue earned.")
                        .font(.body)
//                    VStack{
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .foregroundColor(Color(UIColor.systemGray6))
                                
                            HStack(spacing:1){
                                Text("$")
                                    .font(.system(size: 40))
                                TextField("0.00", text: $userVM.user.revenue_per_rvu)
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                                    .keyboardType(.decimalPad)
//                                    .padding(.vertical)
                            }.padding(.horizontal)
//                        }
//                    }.padding(.top)
                    
                    Button( action: {
                        saveRevenuePerRVU()
                    }, label: {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 12.0)
                            Text("Save").foregroundColor(.white)
                        }
                        .frame(height:44)
                    })
                    .padding(.top)
                    .disabled(areVariableEmpty())
                }
            }.padding()
        }
    }
        .isHidden(hideEnterRevenuePerRVU())
        .frame(height:frameHeight())
        
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
    
    func hideEnterRevenuePerRVU() -> Bool {
        if userVM.user.revenue_per_rvu == "" || userVM.user.revenue_per_rvu == nil{
            print(userVM.user.revenue_per_rvu)
            return false
        } else {
            return true
        }
    }
    
    func frameHeight()->CGFloat{
        if hideEnterRevenuePerRVU() {
            return 0
        }else{
            return 352
        }
    }
}

struct SetupRevenuePerRVUView_Previews: PreviewProvider {
    static var previews: some View {
        SetupRevenuePerRVUView()
    }
}
