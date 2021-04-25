//
//  CustomSummaryNavigationBarView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI

struct CustomSummaryNavigationBarView: View {
    
    @State private var presentPhysicianProfileScreen = false
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text("April 2021").font(.subheadline).foregroundColor(.secondary)
                Text("Summary").font(.largeTitle).bold()}.padding(.top)
            Spacer()
            
            Button(action: {
                print("User profile button pressed")
                presentPhysicianProfileScreen.toggle()
            },
            label: {
                
                ZStack {
                    Circle()
                        .frame(width:35)
                        .foregroundColor(.gray)
                    Text("MB")
                        .font(.system(size: 17.5))
                        .foregroundColor(.white)
                        .bold()
                }
                
            })
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
        .sheet(isPresented: $presentPhysicianProfileScreen){
                            PhysicianProfileView()
                        }
    }
}

struct RVUWalletTitleView: View {
    @State private var presentPhysicianProfileScreen = false
    
    var body: some View {
        
        VStack(alignment:.leading, spacing:0){
            Text("APRIL 2021")
                .font(.title2)
                .foregroundColor(.secondary)
                .fontWeight(.bold)
            HStack{
                
                Text("Summary").font(.largeTitle).bold().foregroundColor(.clear)
                
                Spacer()
                
                Button(action: {
                    print("User profile button pressed")
                    presentPhysicianProfileScreen.toggle()
                },
                label: {
                    
                    ZStack {
                        Circle()
                            .frame(width:35)
                            .foregroundColor(.gray)
                        Text("MB")
                            .font(.system(size: 17.5))
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                })
            }
            
            
            .sheet(isPresented: $presentPhysicianProfileScreen){
                PhysicianProfileView()
            }
//
//            Spacer()
//            HStack(alignment:.lastTextBaseline){
//                Text("Summary").font(.title).fontWeight(.heavy).foregroundColor(.primary)
//                Spacer()
////                Button(action: {}, label: {
////                        Text("Edit")})
//                
//            }.padding(.horizontal,20)
//            Divider().padding([.horizontal,.bottom])
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: -1, trailing: 20))
    }
}

struct menuButton: View {
    @State var userSelection = "This month"

    var body: some View{

        Menu(content: {
            Button(action: {
                print("Home button pressed.")
                self.userSelection = "This month"
                print("Site selected is now \(userSelection)")
                
            }, label: {
                if self.userSelection == "This month"{
                    Image(systemName: "checkmark")
                    Text("This month")
                }else{
                    Text("This month")
                }
            })
            
            Button(action: {
                print("Home button pressed.")
                
                //Assign site variable to clubcorners
                self.userSelection = "This quarter"
                print("Site selected is now \(userSelection)")
            }, label: {
                HStack {
                    if userSelection == "This quarter"{
                        Image(systemName: "checkmark")
                        Text("This quarter")
                    }else{
                        Text("This quarter")
                    }
                }
            })
            
            Button(action: {
                print("Home button pressed.")
                
                //Assign site variable to clubcorners
                self.userSelection = "This year"
                print("Site selected is now \(userSelection)")
            }, label: {
                HStack {
                    if userSelection == "This year"{
                        Image(systemName: "checkmark")
                        Text("This year")
                    }else{
                        Text("This year")
                    }
                }
            })
            
        }, label: {
            Text(userSelection)
        })
    }
}

struct CustomSummaryNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        RVUWalletTitleView()
    }
}
