//
//  CircularProgressView.swift
//  writezi
//
//  Created by hao jun on 17/11/21.
//

import SwiftUI

struct CircularProgressView: View {
    
    var fullscore: CGFloat
    var score: CGFloat
    
    var body: some View {
        ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(.red)
                    
                    Circle()
                        .trim(from: 0, to: score/fullscore)
                        .stroke(style: .init(lineWidth: 20.0,
                                             lineCap: .round,
                                             lineJoin: .round))
                        .opacity(0.8)
                        .foregroundColor(.red)
                        .rotationEffect(Angle(degrees: 270))
            Text("Score: \(Int(score))/\(Int(fullscore)) (\(Int(score/fullscore*100))%)")
                .font(.title2)
                }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(fullscore: 3, score: 2)
    }
}
