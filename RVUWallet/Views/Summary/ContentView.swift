//
//  ContentView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import Foundation
import SwiftUI
import NavigationBarLargeTitleItems
import FirebaseAuth
import LocalAuthentication


extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var startOfQuarter: Date {
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!

                var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)

                let newMonth: Int
                switch components.month! {
                case 1,2,3: newMonth = 1
                case 4,5,6: newMonth = 4
                case 7,8,9: newMonth = 7
                case 10,11,12: newMonth = 10
                default: newMonth = 1
                }
                components.month = newMonth
                return Calendar.current.date(from: components)!
    }
    
    var endOfQuarter: Date {
        let endOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!

                var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)

                let newMonth: Int
                switch components.month! {
                case 1,2,3: newMonth = 3
                case 4,5,6: newMonth = 6
                case 7,8,9: newMonth = 9
                case 10,11,12: newMonth = 12
                default: newMonth = 3
                }
                components.month = newMonth
                return Calendar.current.date(from: components)!
    }
    
    func getThisQuarter() -> String {
        let this_quarter = Date().startOfQuarter
        let end_quarter = Date().endOfQuarter
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter2.dateFormat = "MMMM yyyy"
        let start_quarter_string = dateFormatter.string(from: this_quarter)
        let end_quarter_string =  dateFormatter2.string(from: end_quarter)
        return start_quarter_string + "-" + end_quarter_string
    }
    
    var startOfYear: Date {
        var components = DateComponents()
        let year = Calendar.current.component(.year, from: Date())
        let startOfThisYear = Calendar.current.date(from: DateComponents(year: 1, month: 1, day: 1))
        components.year = 1
        components.month = 1
        components.day = 1
        return startOfThisYear!
//            Calendar.current.date(from: DateComponents(year: 1, month: 1, day: 1))
    }
    
    func getThisYear() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: now)
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
}

class UserInfo: ObservableObject {
    
    enum AuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAutheticated: AuthState = .undefined
    
    @Published var user_id = ""
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var alert = false
    @Published var alert_message = ""
    
    @Published var isLoading = false
    
    @Published var store_info = false
    
    @Published var hideTrailingView = false
    
    @AppStorage("stored_User") var stored_user = ""
    @AppStorage("stored_Password") var stored_password = ""
    
    @AppStorage("status") var logged = false
    
    var authDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        authDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else{
                self.isUserAutheticated = .signedOut
                return
            }
            self.isUserAutheticated = .signedIn
        })
    }
    
    func authenticateUser(){
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To unlock \(self.email)"){(status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.email = self.stored_user
                self.password = self.stored_password
                self.signIn(email: self.email, password: self.password)
            }
        }
    }
    
    func signIn(email:String, password:String){
        
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            self.isLoading = false
            
//            if let error = error as? NSError {
//                switch AuthErrorCode(rawValue: error.code) {
//                case .operationNotAllowed:
//                    print("Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
//                case .userDisabled:
//                    print("Error: The user account has been disabled by an administrator.")
//                case .wrongPassword:
//                    print("The password is invalid or the user does not have a password.")
//                case .invalidEmail:
//                    print("Indicates the email address is malformed.")
//                default:
//                    print("Error: \(error.localizedDescription)")
//                }
            
            if let error = error {
                self.alert_message = error.localizedDescription
                self.alert.toggle()
            }
            
            if self.stored_user == "" || self.stored_password == ""{
                self.store_info.toggle()
                print("Alerting user that they are able to use Face ID.")
                return
            }
            
            self.user_id = Auth.auth().currentUser?.uid ?? ""
            
            self.logged = true
            print("Username and password for app is as follows:")
            print(self.stored_user)
            print(self.stored_password)
        }
    }
    
    func signOut() {
        do {
          try Auth.auth().signOut()
            print("User signed out.")
        } catch {
          print("Sign out error")
        }
    }
    
    func getBioMetricStatus()-> Bool{
        let scanner = LAContext()
        if scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            return true
        }
        return false
    }
    
    
}

struct ParentView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject var userInfo = UserInfo()
    
    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @AppStorage("status") var logged = false
    
    @AppStorage("userID") var user_id = ""
    
    var body: some View{
        Group{
            if logged {
                ContentView(proceduresVM:proceduresVM, userVM: userVM)
            }
            else{
                MainAuthView()
            }
            
//            if userInfo.isUserAutheticated == .undefined {
//                Text("Loading...")
//            } else if userInfo.isUserAutheticated == .signedOut{
//                MainAuthView()
//            } else {
//                ContentView(proceduresVM:proceduresVM, userVM: userVM)
//                    .onChange(of: scenePhase) { (newScenePhase) in
//                        switch newScenePhase {
//                        case .active:
//                            print("scene is now active!")
//                        case .inactive:
//                            print("scene is now inactive!")
//                        case .background:
//                            print("scene is now in the background!")
//                        @unknown default:
//                            print("Apple must have added something new!")
//                        }
//                    }
//            }
        }.onAppear {
            self.userInfo.configureFirebaseStateDidChange()
            let user_id = Auth.auth().currentUser?.uid
            proceduresVM.subscribe(user_id: user_id ?? "")
            userVM.fetchUser(documentId: user_id ?? "")
            self.user_id = user_id ?? ""
        }
    }
}

struct ContentView: View {

    @EnvironmentObject var userInfo: UserInfo

    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    @ObservedObject var cptsVM = CPTsViewModel()
    
    @ObservedObject var cptVM = CPTViewModel()
    
    @ObservedObject var physiciansVM = PhysiciansViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var user_id = ""
    @State var hideTrailingView = false
    
//    init() {
//        UIToolbar.appearance().barTintColor = UIColor.systemGroupedBackground
//    }
    
    var body: some View {
        NavigationView{
            
            ZStack(alignment:.bottom){
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    SummaryView(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: Double(userVM.user.revenue_per_rvu ) ?? 0.0)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    RecentProceduresList(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: Double(userVM.user.revenue_per_rvu ) ?? 0.0, cpt: cptVM.cpt)
                        .padding(EdgeInsets(top: padding(), leading: padding(), bottom: 0, trailing: padding()))
                        .isHidden(hideRecentProcedures())

//                        FinishSetupView().padding([.horizontal, .top],20)
//                            .isHidden(hideEnterRevenuePerRVU())
                    }
                
//                AddNewProcedureButton()
            }
            .navigationBarTitle("Summary")
            .onAppear(perform: {
                self.user_id = Auth.auth().currentUser?.uid ?? ""
                self.proceduresVM.subscribe(user_id: user_id)
//                self.userVM.fetchUser(documentId: user_id)
                self.userInfo.hideTrailingView = false
            })
            .onDisappear(perform: {
    
                self.userInfo.hideTrailingView = true
            })
            .navigationBarTitleDisplayMode(.large)
            .navigationBarLargeTitleItems(trailing:ProfileIcon())
            
            .toolbar(content: {
                ToolbarItemGroup(placement: .bottomBar) {
                    AddNewProcedureButton()
                    Spacer()
                }
            })
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
    
    func hideRecentProcedures()-> Bool {
        if proceduresVM.procedures.count == 0 {
            return true
        }else{
            return false
        }
    }
    
    func padding()->CGFloat{
        if hideRecentProcedures(){
            return 0
        }else{
            return 20
        }
    }
    
    func hideEnterRevenuePerRVU() -> Bool {
        if userVM.user.revenue_per_rvu == "" || userVM.user.revenue_per_rvu == nil{
            return false
        } else {
            return true
        }
    }
}

struct ProfileIcon: View {
    
    @State private var presentPhysicianProfileScreen = false
    
    @ObservedObject var userVM = UserViewModel()
    
    @EnvironmentObject var userInfo: UserInfo
    
    @State var user_id = ""
    
    var body: some View {
        
        Button(action: {
            print("User profile button pressed")
            presentPhysicianProfileScreen.toggle()
        },
        label: {
            
            ZStack {
                Circle()
                    .frame(width:35, height:35)
                    .foregroundColor(.gray)
                HStack(spacing:-1){
                    Text(userVM.user.first_name.prefix(1))
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .bold()
                    Text(userVM.user.last_name.prefix(1))
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
        })
        .isHidden(self.userInfo.hideTrailingView)
        .padding(.trailing)
        .onAppear{
            let userInfo = Auth.auth().currentUser
            self.user_id = userInfo?.uid ?? ""
            userVM.fetchUser(documentId:user_id)
        }
        .sheet(isPresented: $presentPhysicianProfileScreen){
            PhysicianProfileView()
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        
    }
}

struct AddNewProcedureButton: View {
  
    @State private var presentNewProcedureScreen = false

    var body: some View {
        HStack{
            Button(action: {
                print("Adding new procedure")
                presentNewProcedureScreen.toggle()
            }, label: {
                HStack{
                    Image(systemName: "plus.circle.fill").font(.system(size: 25))
                    Text("New Procedure").font(.title3).bold()
                    
                }
            }).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }
        .sheet(isPresented: $presentNewProcedureScreen){
            ProcedureEditView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}


//            .background(NavConfigurator { nav in
//                nav.accessibilityNavigationStyle = .separate
//                            nav.navigationBar.barTintColor = UIColor(named: "primaryBlue")
//                            nav.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
//                })
//            .onAppear(perform: {
//                let appearance = UINavigationBar.appearance()
//                appearance.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//                appearance.shadowImage = UIImage()
//                UINavigationBar.appearance().isTranslucent = true
//                UINavigationBar.appearance().backgroundColor = .clear
//                UINavigationBar.appearance().largeTitleTextAttributes =
//                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .heavy)]
//            })
