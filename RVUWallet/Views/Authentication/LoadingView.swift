//
//  LoadingView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 5/1/21.
//

import SwiftUI

struct LoadingView: View {
    @State var animate = false
    var body: some View {

            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 60, height: 60)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .padding(40)
                .background(Color.white)
                .cornerRadius(15)
      
        .onAppear(perform: {
            withAnimation(Animation.linear.speed(0.6).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        })
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
