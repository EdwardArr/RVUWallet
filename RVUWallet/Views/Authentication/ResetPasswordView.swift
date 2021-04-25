//
//  ResetPasswordView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/21/21.
//

import SwiftUI
import FirebaseAuth

struct ResetPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var email:String
    
    @State private var showAlert = false
    @State private var errString: String?
    
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                    HStack{
                        TextField("Enter email address", text:$email)
                            .padding(.horizontal)
                    }
                }
                .frame(height:44)
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    resetPassword(email: self.email) {(result) in
                        switch result {
                        case .failure(let error):
                            self.errString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(.white)
                        Text("Reset Password")
//                            .foregroundColor(.systemRed)
                    }
                }).disabled(areVariablesEmpty())
                .frame(height:44)
                .padding([.horizontal, .bottom])
            }.padding(.top)
            .toolbar{
                ToolbarItem(placement:.principal){
                    Text("Reset Password")
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
            .navigationBarItems(leading:
                                    Button(action: {handleCancelTapped()}, label: {
                                        Text("Cancel")
                                            .font(.body)
                                    })
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .alert(isPresented: $showAlert){
                Alert(title: Text("Success"), message: Text(self.errString ?? "Reset password email sent successfully. Check your email."), dismissButton: .default(Text("OK")){
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    func areVariablesEmpty() -> Bool {
        if email != "" {
            return false
        }else{
            return true
        }
    }
    
    func resetPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
        )}
}

//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView(email: )
//    }
//}
