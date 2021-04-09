//
//  PersonalPhysicianDetails.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/6/21.
//

import SwiftUI

struct PersonalPhysicianDetails: View {
    var body: some View {
        List{
            Section{
                HStack{
                    Spacer()
                ZStack {
                    Circle()
                        .frame(width:100,height: 100)
                        .foregroundColor(.gray)
                    Text("MB")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .bold()
                }.padding(.vertical,30)
                    Spacer()
                }
//                Divider().edgesIgnoringSafeArea(.horizontal)
                HStack{
                    Text("First Name")
                    Spacer()
                    Text("Michael")
                }
//                Divider().padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                HStack{
                    Text("Last Name")
                    Spacer()
                    Text("Blaney")
                }
                
                HStack{
                    Text("Phone Number")
                    Spacer()
                    Text("+1 (706) 284-3185")
                }
            }
            
            Section(footer:Text("Revenue is used to calculate total revenue.")){
                
                HStack{
                    Text("Revenue per RVU")
                    Spacer()
                    Text("$54.00")
                }
            }
            
        }
        .offset(y:-40)
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Personal Details"), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    print("User pressed on edit profile")
                                }, label: {
                                    Text("Edit").font(.body)
                                }))
        .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea()
                                
        
    }
}

struct PersonalPhysicianDetails_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPhysicianDetails()
    }
}
