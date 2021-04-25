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

class UserInfo: ObservableObject {
    
    enum AuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAutheticated: AuthState = .undefined
    
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
    func signOut() {
        do {
          try Auth.auth().signOut()
            print("User signed out.")
        } catch {
          print("Sign out error")
        }
    }
}

struct ParentView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @EnvironmentObject var userInfo: UserInfo
    
//    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View{
        Group{
            if userInfo.isUserAutheticated == .undefined {
                Text("Loading...")
            } else if userInfo.isUserAutheticated == .signedOut{
                MainAuthView()
            } else {
                ContentView()
                    .onChange(of: scenePhase) { (newScenePhase) in
                        switch newScenePhase {
                        case .active:
                            print("scene is now active!")
                        case .inactive:
                            print("scene is now inactive!")
                        case .background:
                            print("scene is now in the background!")
//                            self.userInfo.signOut()
                        @unknown default:
                            print("Apple must have added something new!")
                        }
                    }
            }
        }.onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView: View {

//    @EnvironmentObject var userVM: UserViewModel
    
    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    @ObservedObject var cptsVM = CPTsViewModel()
    
    @ObservedObject var cptVM = CPTViewModel()
    
    @ObservedObject var physiciansVM = PhysiciansViewModel()
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var user_id = ""
    
    init() {
        UIToolbar.appearance().barTintColor = UIColor.systemGroupedBackground
    }
    
    var body: some View {
        NavigationView{
            
            ZStack(alignment:.bottom){
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    SummaryView(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: Double(userVM.user.revenue_per_rvu ?? "") ?? 0.0)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    RecentProceduresList(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: Double(userVM.user.revenue_per_rvu ?? "") ?? 0.0, cpt: cptVM.cpt)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        .isHidden(hideRecentProcedures())
                        
                    FinishSetupView().padding([.horizontal, .top],20)
                        .isHidden(hideEnterRevenuePerRVU())
               
                }
//                AddNewProcedureButton()
            }
            .navigationBarTitle("Summary")
            .onAppear(perform: {
                let userInfo = Auth.auth().currentUser
                self.user_id = userInfo?.uid ?? ""
                proceduresVM.subscribe(user_id: user_id)
                userVM.fetchUser(documentId: self.user_id)
            })
            .navigationBarLargeTitleItems(trailing:ProfileIcon())
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar(content: {
                ToolbarItemGroup(placement: .bottomBar) {

                    AddNewProcedureButton()
//
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
    
    func hideEnterRevenuePerRVU() -> Bool {
        if userVM.user.revenue_per_rvu == "" || userVM.user.revenue_per_rvu == nil{
            return false
        } else {
            return true
        }
    }
    
    func getUser(){
        let userInfo = Auth.auth().currentUser
        self.user_id = userInfo?.uid ?? ""
        userVM.fetchUser(documentId:user_id)
    }
    
}

struct ProfileIcon: View {
    
    @State private var presentPhysicianProfileScreen = false
    
    @ObservedObject var userVM = UserViewModel()
    
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
