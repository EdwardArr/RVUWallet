//
//  ContentView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI


struct ParentView: View {
    var body: some View{
        NavigationView{
            ContentView(bgColor: .blue)
        }
    }
}

struct ContentView: View {

    @State var bgColor: Color

    var body: some View {


            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    
                    RVUWalletTitleView()
                    
                    SummaryView()

                    NavigationLink(
                        destination:
                            AllProceduresListView()
                            .navigationTitle("All Procedures")
                            .navigationBarItems(trailing: Text("Export Data").font(.body).foregroundColor(.blue))
                            .listStyle(InsetGroupedListStyle())
                        ,
                     label: {
                         SeeAllProcedureDataButton()
                            
                     }).padding(.bottom,15)
                    
//                    RecentProceduresList().padding(.bottom,15)
                    
                    ProcedureTypeHGridView()
                    
                }
//                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                AddNewProcedureButton(bgColor: bgColor)

            }
            
            .navigationBarHidden(true)
//            .navigationBarTitle("Summary")
//            .navigationBarItems(trailing: menuButton())
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))

    }
}

struct AddNewProcedureButton: View {
    @State private var presentNewProcedureScreen = false
    @State var bgColor: Color
    
    var body: some View {
        HStack{
            Button(action: {
                print("Adding new procedure")
                presentNewProcedureScreen.toggle()
            }, label: {
                HStack{
                    Image(systemName: "plus.circle.fill").font(.system(size: 25))
                    Text("New Procedure").font(.title3).bold()
                    
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 00))
            })
            Spacer()
        }.sheet(isPresented: $presentNewProcedureScreen){
            ProcedureEditView(document: .constant(TextFile()), bgColor: bgColor)
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
