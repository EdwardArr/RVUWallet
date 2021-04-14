//
//  PersonalPhysicianDetails.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/6/21.
//

import SwiftUI

enum personalDetailsMode {
    case view, edit
}

struct PersonalPhysicianDetails: View {
    
    @State var mode:personalDetailsMode = .view
    
    @State var descriptor = ["First Name", "Last Name", "Phone Number"]
    @State var personalInfo = ["Michael", "Blaney", "+1 (706) 285-3186"]
    
    @State var counter = 0
    
    
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
                    Text("MB")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .bold()
                }.padding(.vertical,30)
                    Spacer()
                }
                
                ForEach(Array(zip(descriptor, personalInfo)), id:\.0){ text in

            
                    PhysicianPersonalDetailRow(descriptor:text.0, personalInfo:text.1, keyboardType: .namePhonePad, mode:mode)
                    
                }

            }
            
            Section(footer:Text("Revenue is used to calculate total revenue.")){
                
                PhysicianPersonalDetailRow(descriptor:"Revenue per RVU", personalInfo:"$54.00", keyboardType: .decimalPad, mode:mode)
        
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
                                        mode = .view
                                    }else if mode == .view{
                                    mode = .edit
                                    }
                                }, label: {
                                    trailingNavItem.font(.body)
                                }))
        .background(Color(UIColor.systemGroupedBackground)).ignoresSafeArea()
                                
        
    }
}

struct PersonalPhysicianDetails_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPhysicianDetails(mode: .view)
    }
}
