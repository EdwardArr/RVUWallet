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
                .trim(from: 0, to: 0.7)
                .stroke(Color.gray, lineWidth: 6)
                .frame(width: 30, height: 30)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .padding(40)
                .background(Color.white)
                .cornerRadius(15)
      
        .onAppear(perform: {
            withAnimation(Animation.linear.speed(0.7).repeatForever(autoreverses: false)){
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
