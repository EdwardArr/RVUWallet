//
//  LoginView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/21/21.
//

import SwiftUI
import Firebase
import LocalAuthentication

struct LoginView: View {
    
    @StateObject var userInfo = UserInfo()
    
    @ObservedObject var physicianVM = PhysicianViewModel()
    
    @State var user_id = ""
    @State var email = ""
    @State var password = ""
    
    @State var loginWithApple = false
    
    @State var picker = true
    
    @State private var presentResetPasswordScreen = false
    
    @State var showAlert = false
    
    // when first user logged in via email store this for future biometric login
    @AppStorage("stored_User") var stored_user = ""
    @AppStorage("stored_Password") var stored_password = ""
    
    @AppStorage("status") var logged = false
    
    @State var startAnimate = false
//    @State private var authError: EmailAuthError?
    
    var body: some View {
//        NavigationView{
        ScrollView {
            ZStack{
                VStack{
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 12, style:.continuous)
                                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                            VStack {
                                HStack{
                                    TextField("Email", text:$userInfo.email)
                                        .autocapitalization(.none)
                                        .keyboardType(.emailAddress)
                                        .textContentType(.emailAddress)
                                        .padding(.horizontal)
                                }
                                Divider().padding(.leading)
                                HStack(alignment: .bottom){
                                    SecureField("Password", text:$userInfo.password)
                                        .textContentType(.password)
                                        .autocapitalization(.none)
                                    Spacer()
                                    if userInfo.getBioMetricStatus(){
                                        Button(action: {
                                            userInfo.authenticateUser()
                                        }, label: {
                                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                                .font(.title)
                                        })
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }.frame(height:88)
                        Spacer()
                        Button(action: {
                            userInfo.signIn(email: self.userInfo.email, password: self.userInfo.password)
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12)
                                Text("Sign In")
                                    .foregroundColor(.white)
                            }
                        }).disabled(areVariablesEmpty()).frame(height:44)
                    }
                    .padding([.horizontal,.top])
                    
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
            }
            if userInfo.isLoading{
                LoadingView()
            }
        }
        .navigationTitle(Text("Login"))
        .alert(isPresented: $userInfo.store_info){
            Alert(title: Text("Message"), message: Text("Store credentials to use Face ID or Touch ID"), primaryButton: .default(Text("Accept"), action: {
                stored_user = userInfo.email
                stored_password = userInfo.password
                self.logged = true
            }), secondaryButton: .cancel() {
                self.logged = true
            })
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
    
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
        if self.userInfo.email != "" && self.userInfo.password != "" {
            return false
        }else{
            return true
        }
    }
    
//    func signIn(email:String, password:String){
//        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
//          if let error = error as? NSError {
//            switch AuthErrorCode(rawValue: error.code) {
//            case .operationNotAllowed:
//              print("Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
//            case .userDisabled:
//              print("Error: The user account has been disabled by an administrator.")
//            case .wrongPassword:
//              print("The password is invalid or the user does not have a password.")
//            case .invalidEmail:
//              print("Indicates the email address is malformed.")
//            default:
//                print("Error: \(error.localizedDescription)")
//            }
//          } else {
//            print("User signs in successfully")
//            let userInfo = Auth.auth().currentUser
//            self.user_id = userInfo?.uid ?? ""
//            self.email = userInfo?.email ?? ""
//            userVM.id = self.user_id
//            userVM.fetchUser(documentId: String(self.user_id))
//          }
//        }
//    }
    
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
