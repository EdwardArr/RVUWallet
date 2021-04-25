//
//  LoginView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/21/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @ObservedObject var physicianVM = PhysicianViewModel()
    @ObservedObject var userVM = UserViewModel()
    
    @State var user_id = ""
    @State var email = ""
    @State var password = ""
    
    @State var loginWithApple = false
    
    @State var picker = true
    
    @State private var presentResetPasswordScreen = false
    
    var body: some View {
//        NavigationView{
        ScrollView {
           
            ZStack{
                RoundedRectangle(cornerRadius: 12, style:.continuous)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                VStack {
                    HStack{
                        TextField("Email", text:$email)
                            .padding(.horizontal)
                    }
                    Divider().padding(.leading)
                    HStack(alignment: .bottom){
                        SecureField("Password", text:$password)
                        Spacer()
                        Button(action: {
                            
                            signIn()
                            
                        }, label: {
                            Image(systemName: "arrow.forward.circle")
                                .font(.title)
                                
                        }).disabled(areVariablesEmpty())
                    }
                    .padding(.horizontal)
                }
            }.frame(height:88)
            
            .padding([.horizontal,.top])
            
            VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12, style:.continuous)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                Toggle("FaceID", isOn: $loginWithApple)
                    .padding(.horizontal)
            }
            .frame(height:44)
            }
            .padding([.horizontal,.top])
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .foregroundColor(.primary)
                                Text("Login wirh FaceID").foregroundColor(Color.systemGray)
                            }
                            .frame(height:buttonHeight())
                            .padding(.horizontal)
            }).isHidden(hideFaceIDButton())
            
            ZStack{
                RoundedRectangle(cornerRadius: 12, style:.continuous)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                Button(action: {presentResetPasswordScreen.toggle()}, label: {
                    HStack{
                        Text("Forgot Password")
                        Spacer()
                    }.padding(.leading)
                })
            }
            .frame(height:44)
            .padding([.horizontal,.top])
            .sheet(isPresented: $presentResetPasswordScreen, content: {
                ResetPasswordView(email:$email)
            })
            
            Spacer()
        }
        .navigationTitle(Text("Login"))

        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
    //    }
    
    func hideFaceIDButton()-> Bool {
        if loginWithApple{
            return false
        } else {
            return true
        }
    }
    
    func buttonHeight() -> CGFloat {
        if loginWithApple{
            return 44.0
        } else {
            return 0.0
        }
    }
    
    func areVariablesEmpty() -> Bool {
        if email != "" && password != "" {
            return false
        }else{
            return true
        }
    }
    
    func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              print("Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
            case .userDisabled:
              print("Error: The user account has been disabled by an administrator.")
            case .wrongPassword:
              print("The password is invalid or the user does not have a password.")
            case .invalidEmail:
              print("Indicates the email address is malformed.")
            default:
                print("Error: \(error.localizedDescription)")
            }
          } else {
            print("User signs in successfully")
            let userInfo = Auth.auth().currentUser
            self.user_id = userInfo?.uid ?? ""
            self.email = userInfo?.email ?? ""
            userVM.id = self.user_id
            userVM.fetchUser(documentId: String(self.user_id))
          }
        }
    }
    
    func mergeUser() {
        physicianVM.physician.id = self.user_id
        physicianVM.physician.email = self.email
    }
    
}

struct faceOrTouchIDButton: View {
    
    var isDisabled:Bool
    
    var body: some View {
        
        Button(action: {
            
            
            
        }, label: {
            Image(systemName: "arrow.forward.circle")
                .font(.title)
                
        }).disabled(isDisabled)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
