//
//  SplashScreenView.swift
//  HearTrack
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 04/02/25.
//

import SwiftUI

struct SplashScreenView2: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x:125, y:350))
                path.addLine(to: CGPoint(x: 150, y: 300))
                path.addLine(to: CGPoint(x: 185, y: 350))
                path.addLine(to: CGPoint(x: 215, y: 300))
                path.addLine(to: CGPoint(x: 245, y: 350))
                path.addLine(to: CGPoint(x: 185, y: 450))
                path.addLine(to: CGPoint(x: 125, y: 350))
                
            }.stroke(Color.black)
            
            Path { path in
                path.move(to: CGPoint(x: 125, y: 350))
                path.addEllipse(in: CGRect(x: 120, y: 341, width: 15, height: 15))
                path.addEllipse(in: CGRect(x: 142.5, y: 299, width: 15, height: 15))
                path.addEllipse(in: CGRect(x: 179, y: 341, width: 15, height: 15))
                path.addEllipse(in: CGRect(x: 207, y: 299, width: 15, height: 15))
                path.addEllipse(in: CGRect(x: 120, y: 341, width: 15, height: 15))
                path.addEllipse(in: CGRect(x: 120, y: 341, width: 15, height: 15))
                path.addEllipse(in: CGRect(x: 120, y: 341, width: 15, height: 15))
            }
        }
    }
}

#Preview {
    SplashScreenView2()
}
