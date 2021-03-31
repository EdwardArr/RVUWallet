//
//  ContentView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 3/13/21.
//

import SwiftUI

struct ContentView: View {
    @State private var presentNewProcedureScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    HStack{
                    VStack(alignment:.leading){
                        Text("March 2021").font(.subheadline).foregroundColor(.secondary)
                        Text("Summary").font(.largeTitle).bold()}.padding(.top)
                        Spacer()
                    }.padding(.bottom,5)
                    
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                    StatsMiniDashboard()
                 
                    LazyVStack{
                        ForEach(0..<proceduresList.count) { item in
                            Section(
                                header:
                                    HStack{
                                        Text(proceduresList[item].date).font(.title3).bold()
                                                                            Spacer()
                                    }.padding(.vertical,10)
                            ){
                                // Code below should actually be an if statement
                                ForEach(0..<proceduresList.count) { item in
                                    ZStack{
                                        NavigationLink(destination: ProcedureDetailView()){}
                                            .opacity(0.0)
                                            .buttonStyle(PlainButtonStyle())
                                        HStack(alignment:.top){
                                            RVURow()
                                            Spacer()
                                    Text("3/31/21")
                            }
                                        .padding(.vertical,10)
                            }
                        }
                    }.textCase(nil).foregroundColor(.primary)
                    }
                    
                }
                .sheet(isPresented: $presentNewProcedureScreen){
                    ProcedureEditView(document: .constant(TextFile()))
                }
                
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: Text("This month").foregroundColor(.blue))
                HStack{
                Button(action: {
                    print("Adding new procedure")
                    presentNewProcedureScreen.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "plus.circle.fill").font(.system(size: 25))
                        Text("New Procedure").font(.title3).bold()
                       
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 00))
                })
                    Spacer()
                    Button(action: {
                        print("Adding new procedure")
                        presentNewProcedureScreen.toggle()
                    }, label: {
                        HStack{
                            
                            Text("Add CPT").font(.body)
                           
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    })
            }
            }
            }
            
        }
        
    }
}

struct StatsMiniDashboard: View {
    var body: some View{
        HStack(spacing:10){
            SingleStat()
//            Spacer()
            SingleStat()
        }
    }
}

struct SingleStat: View {
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(Color(UIColor.secondarySystemGroupedBackground)).cornerRadius(8)
            HStack(alignment: .top){
                VStack(alignment:.center, spacing:1){
//                    Image(systemName: "plus").padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
//                    Spacer()
                    Text("Procedure")
                        .font(.headline)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                    Text("104.18").font(.title2).foregroundColor(.primary).bold().padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
                }
//                Spacer()
//                Text("104.18").font(.title2).foregroundColor(.primary).bold().padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }.frame(height:70)
    }
}


struct RVURow: View {
    let number = [1,2,3,4,5,6,7,8,9]
    
    var body: some View{
        VStack(alignment: .leading, spacing:5){
            
                Text("Lap gastric bypass")
                    .font(.headline)
//                Spacer()
                Text("14.98").font(.subheadline)
            
        }
    }
}


struct AddNewProcedureButton: View{
    var body: some View{
        Button(action: {
            print("Adding new procedure")
            //            presentNewProcedureScreen.toggle()
        }, label: {
            HStack{
                Image(systemName: "plus.circle.fill").font(.system(size: 60))
                Text("New Procedure").bold().font(.title2)
                Spacer()
            }.padding(.vertical)
        })
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
