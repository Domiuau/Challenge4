//
//  SplashScreenView2.swift
//  HearTrack
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 04/02/25.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var vm = PressaoViewModel()
    
    @State private var drawProgress1: CGFloat = 0.0
    @State private var drawProgress2: CGFloat = 0.0
    @State private var drawProgress3: CGFloat = 0.0
    @State private var isActive = false
    var body: some View {
        if isActive{
            TabBarComponent(pressaoViewModel: vm)
        }else{
            VStack{
                ZStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .mask(
                            Rectangle()
                                .size(width: 200 * drawProgress1, height: 99)
                                .offset(x: -100 + (200 * drawProgress1) / 2, y: 0)
                        )
                        .onAppear {
                            withAnimation(.linear(duration: 1.0)) {
                                drawProgress1 = 1.0
                            }
                        }
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .mask(
                            Rectangle()
                                .size(width: 200 * drawProgress2, height: 101)
                                .offset(x: 200 * (1 - drawProgress2) , y:99)
                        )
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(.linear(duration: 1.0)) {
                                    drawProgress2 = 1.0
                                }
                            }
                        }
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){
                        self.isActive = true
                    }
                }
                
                Image("appNome")
                    .resizable()
                    .scaledToFit()
                    .padding(40)
                    .opacity(drawProgress3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.linear(duration: 1.0)) {
                                drawProgress3 = 1.0
                            }
                        }
                    }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
