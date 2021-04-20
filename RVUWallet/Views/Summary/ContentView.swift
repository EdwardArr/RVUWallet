//
//  ContentView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI


struct ParentView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    var body: some View{
//        ScrollView{
            ContentView()
//            AllProceduresListView()
//        }
                .onChange(of: scenePhase) { (newScenePhase) in
                    switch newScenePhase {
                    case .active:
                        print("scene is now active!")
                    case .inactive:
                        print("scene is now inactive!")
                        proceduresVM.unsubscribe()
                    case .background:
                        print("scene is now in the background!")
                        proceduresVM.unsubscribe()
                    @unknown default:
                        print("Apple must have added something new!")
                    }
                }
    }
}

struct ContentView: View {

    @ObservedObject var proceduresVM = ProceduresViewModel()
    
    @ObservedObject var cptsVM = CPTsViewModel()
    
    @ObservedObject var cptVM = CPTViewModel()
    
    @ObservedObject var physiciansVM = PhysiciansViewModel()
    
    @State private var presentPhysicianProfileScreen = false
    
//    init() {
//        UIToolbar.appearance().barTintColor = UIColor.clear
//        UIToolbar.appearance().backgroundColor = UIColor.clear
//    }
    
    var body: some View {
        NavigationView{
            
            ZStack(alignment:.bottom){
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    RVUWalletTitleView()
                        .offset(y:-89)
                    HStack{
                        Text("Performance")
                        .font(.title2)
                        .bold()
                        Spacer()
                    }
                        .offset(y:-89)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: -1, trailing: 20))
                    SummaryView(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: 54.19)
                        .offset(y:-89)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    
                    RecentProceduresList(proceduresList: proceduresVM.procedures, totalRVU: proceduresVM.totalRVU, revenuePerRVU: 54.19, cpt: cptVM.cpt)
                        .offset(y:-89)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                AddNewProcedureButton()
            }
            .navigationBarTitle("Summary")
            .onAppear(perform: {proceduresVM.subscribe()})
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("User profile button pressed")
                        presentPhysicianProfileScreen.toggle()
                    },
                    label: {
                        
                        ZStack {
                            Circle()
                                .frame(width:35, height:35)
                                .foregroundColor(.gray)
                            Text("MB")
                                .font(.system(size: 17.5))
                                .foregroundColor(.white)
                                .bold()
                        }.offset(y:-5)
                    })
                    .sheet(isPresented: $presentPhysicianProfileScreen){
                        PhysicianProfileView()
                    }
            )
//            .toolbar(content: {
//                ToolbarItemGroup(placement: .bottomBar) {
//
//                    AddNewProcedureButton()
//                        .padding(.top,20)
//                    Spacer()
//                    }
//            })
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
    
//    func hideRecentProcedures()-> 
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
            }).padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
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
