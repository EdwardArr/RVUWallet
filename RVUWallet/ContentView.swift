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
            
            VStack(alignment: .leading){
//                ScrollView{
                
//                StatsMiniDashboard().padding(.horizontal)
//
                List{
                    Section(header:HStack{
                                Text("March 2021").font(.title3).bold()
                        Spacer()
                        Text("123.2").font(.title2).bold()
                        
                    }.padding(.vertical,10)
                    ){
                        ForEach(0..<proceduresList.count) { item in
                            ZStack{
                                NavigationLink(destination: ProcedureDetailView()){}
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                                HStack{
                                Image(systemName: "\((proceduresList.count+13)-item).square").font(.title)
                                RVURow()
                                
                            }.padding(.vertical,10)
                            }
                        }
                    }.textCase(nil).foregroundColor(.primary)
                    
                }.listStyle(PlainListStyle())

                
            
              
                Button(action: {
                    print("Adding new procedure")
                    presentNewProcedureScreen.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "plus.circle.fill").font(.system(size: 30))
                        Text("New Procedure").font(.title3).bold()
                        Spacer()
                    }.padding(.vertical,5)
                })
                .padding(.horizontal)
                .sheet(isPresented: $presentNewProcedureScreen){
                    ProcedureEditView(document: .constant(TextFile()))
                }
            }.navigationTitle("Procedures")
        }
        
    }
}

struct StatsMiniDashboard: View {
    var body: some View{
        HStack{
            SingleStat()
            Spacer()
            SingleStat()
        }
    }
}

struct SingleStat: View {
    var body: some View{
        ZStack{
            Rectangle().foregroundColor(.gray).cornerRadius(8)
            HStack(alignment: .top){
                VStack(spacing:1){
                    Image(systemName: "plus").padding()
                    Text("All").padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Text("34.18").font(.title2).foregroundColor(.white).bold().padding()
            }
        }.frame(height:80)
    }
}


struct RVURow: View {
    let number = [1,2,3,4,5,6,7,8,9]
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Lap gastric bypass").font(.title3)
                Spacer()
                Text("14.98").font(.title3)
            }
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
