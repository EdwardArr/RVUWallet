//
//  RVUWalletApp.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI
import Firebase

@main
struct RVUWalletApp: App {
    
    // call FirebaseApp.configure()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var userInfo = UserInfo()
//    var userVM = UserViewModel()
    
    var body: some Scene {
        WindowGroup() {
            ParentView().environmentObject(userInfo)
//                .environmentObject(userVM)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

