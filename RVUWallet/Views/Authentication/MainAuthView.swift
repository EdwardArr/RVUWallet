//
//  MainAuthView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/21/21.
//

import SwiftUI

struct MainAuthView: View {
    
    @State var picker = true

    var body: some View {
        NavigationView {
            VStack{
                if picker{
                    LoginView()
                } else {
                    SignupView()
                }
            }
            .navigationTitle(picker ? Text("Login"):Text("Signup"))
            .toolbar{
                ToolbarItem(placement:.principal){
                    
                    Picker(selection: $picker, label: Text("What is your favorite color?")) {
                        Text("Login")
                            .tag(true)
                        Text("Signup")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

struct MainAuthView_Previews: PreviewProvider {
    static var previews: some View {
        MainAuthView()
    }
}
