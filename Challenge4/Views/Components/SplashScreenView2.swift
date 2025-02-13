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
    @State private var retanguloVisivel = true
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
                                .zIndex(0)
                        )
                        .onAppear {
                            withAnimation(.linear(duration: 1.0)) {
                                drawProgress1 = 1.0
                            }
                        }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .offset(x: -52.6, y: 53)
                        .rotationEffect(Angle(degrees: 44))
                        .opacity(retanguloVisivel ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                                withAnimation(.easeOut(duration: 0.1)) {
                                    retanguloVisivel = false
                                }
                                
                            }
                        }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 5, height: 5)
                        .offset(x: -20, y: 80)
                        .rotationEffect(Angle(degrees: 77))
                        .opacity(retanguloVisivel ? 1 : 0)
                      
                    
                    
                    
                    
                    
                    
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
                                withAnimation(.linear(duration: 0.5)) {
                                    drawProgress2 = 1.0
                                }
                            }
                        }
                        .zIndex(2)
                }
                
                Image("appNome")
                    .resizable()
                    .scaledToFit()
                    .padding(40)
                    .opacity(drawProgress3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.linear(duration: 0.4)) {
                                drawProgress3 = 1.0
                            }
                        }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    self.isActive = true
                }
            }
            
        }
    }
}


#Preview {
    SplashScreenView()
}
