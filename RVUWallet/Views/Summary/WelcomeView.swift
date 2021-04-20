//
//  WelcomeView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/20/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Not now")
                })
            }
           
            VStack(alignment:.center, spacing:40){
                
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                Text("Ready to start getting serious about your finances? tracking app for medical professionals.")
                    .font(.title2)
                    .bold()
                
            }.padding(.top,40)
            Spacer()
            Button(action: {}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    Text("Setup Account")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                }.frame(height:60)
            })
        }.padding(40)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
