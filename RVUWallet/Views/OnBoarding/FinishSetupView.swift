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
    @ObservedObject var userInfo = UserInfo()

    @State var user_id = ""
//    @State var revenue_per_rvu = ""
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Get More From RVU Wallet")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            VStack{
                SetupRevenuePerRVUView()
                SetupFavoriteCPTCodesView()   
            }
        }.onAppear(perform: {
//            self.user_id = Auth.auth().currentUser?.uid ?? ""
            self.userVM.fetchUser(documentId: userInfo.user_id)
        })
    }

}

struct FinishSetupView_Previews: PreviewProvider {
    static var previews: some View {
        FinishSetupView()
    }
}
