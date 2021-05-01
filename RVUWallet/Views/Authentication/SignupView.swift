//
//  SignupView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/21/21.
//

import SwiftUI
import Firebase

struct SignupView: View {
    
    @ObservedObject var physicianVM = PhysicianViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var first_name = ""
    @State var last_name = ""
    
    @State var email = ""
    @State var user_id = ""
    @State var password = ""
    @State var second_password = ""
    
    var body: some View {
        //        NavigationView{
        ScrollView{
            
            ZStack{
                RoundedRectangle(cornerRadius: 12, style:.continuous)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                VStack {
                    HStack(alignment: .center){
                        TextField("First Name", text: $first_name)
                            .textContentType(.givenName)
                            .padding(.horizontal)
                    }
                    Divider().padding(.leading)
                    HStack(alignment: .center){
                        TextField("Last Name", text: $last_name)
                            .textContentType(.familyName)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .frame(height:89)
            .padding([.horizontal,.top])
            VStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 12, style:.continuous)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                    VStack {
                        HStack{
                            TextField("Email", text:$email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .textContentType(.emailAddress)
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(height:44)
                //                    .padding([.horizontal])
                HStack {
                    Text("Enter valid email address")
                        .font(.footnote)
                    Spacer()
                }
                .padding(.leading)
                .isHidden(isValidEmail(email))
            }.padding([.horizontal,.top])
            
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 12, style:.continuous)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                    VStack {
                        HStack{
                            SecureField("Password", text:$password)
                                .textContentType(.password)
                                .autocapitalization(.none)
                                .padding(.horizontal)
                        }
                        Divider().padding(.leading)
                        HStack(alignment: .bottom){
                            SecureField("Re-enter Password", text:$second_password)
//                                .textContentType(.password)
                                .autocapitalization(.none)
                        }
                        .padding(.horizontal)
                        
                        
                    }
                }
                .frame(height:88)
                
                if isValidPassword(password) == false{
                    HStack{
                        Text("Password must be 6 or more charaters long.")
                            .font(.footnote)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.leading)
                }
                HStack(spacing:1){
                    Text("Passwords match")
                        .font(.footnote)
                        .foregroundColor(.primary)
                    Image(systemName: "checkmark.circle")
                        .font(.footnote)
                        .foregroundColor(.green)
                    Spacer()
                }
                .padding(.leading)
                .isHidden(passwordsMatch())
                
            }.padding([.horizontal, .top])
            
            Spacer()
            
            Button(action: {
                
                createUser()
                
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12, style:.continuous)
                    
                    HStack{
                        Text("Create Account")
                            .font(.headline)
                            .foregroundColor(.white)
                    }.padding(.leading)
                }
            })
            .disabled(areVariablesEmpty())
            .frame(height:44)
            .padding([.horizontal, .top])
            
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
      }
    
    func passwordsMatch() -> Bool {
        
        // Must invert returned bool to set isHidden
        // to true when there is not a match
        
        if password != "" {
            if password == second_password {
                return false
            } else{
                return true
            }
        }else{
            return true
        }
    }
    
    func areVariablesEmpty() -> Bool {
        if email != "" && passwordsMatch() != true {
            return false
        }else{
            return true
        }
    }
    
    func createUser() {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code){
                case .operationNotAllowed:
                print("The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                case .emailAlreadyInUse:
                    print("The email address is already in use by another account.")
                case .invalidEmail:
                    print("The email address is incorrectly formatted.")
                case .weakPassword:
                    print("The password must be 6 characters long or more.")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
              print("User signs up successfully")
              let newUserInfo = Auth.auth().currentUser
              
                
                self.email = newUserInfo?.email ?? ""
                self.user_id = newUserInfo?.uid ?? ""
                mergeUser()
            }
        }
    }
    
    func mergeUser() {
        userVM.user.id = self.user_id
        userVM.user.email = self.email
        userVM.user.first_name = self.first_name
        userVM.user.last_name = self.last_name
        userVM.save()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
