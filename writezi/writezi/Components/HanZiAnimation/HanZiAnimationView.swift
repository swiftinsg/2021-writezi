//
//  HanZiAnimationView.swift
//  writezi
//
//  Created by James Ryan Chen on 20/11/21.
//

import Foundation
import SwiftUI

struct HanZiAnimationView: View {
    let character: Character
    
    // HanZiGraphic
    @State var hanZiGraphic: HanZiGraphic
    
    // Animation related
    @State var strokeIndex: Int
    @State var intervalIndex: Int
    @State var phases: [CGFloat]
    
    // Controlling from parent
    @Binding var paused: Bool
    @Binding var reset: Bool
    @Binding var speed: CGFloat
    
    init(character: Character, speed: Binding<CGFloat> = .constant(3.2), paused: Binding<Bool> = .constant(false), reset: Binding<Bool> = .constant(false)) {
        self.character = character
        self._speed = speed
        self._paused = paused
        self._reset = reset
        
        // Word to HanZiGraphic logic
        
        // First get index in valid-characters.json to find out the relevant line
        // TODO: Abstract this
        let path = Bundle.main.path(forResource: "valid-characters", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let words = try! JSONDecoder().decode([String].self, from: data)
        if let lineIndex = words.firstIndex(of: String(character)) {
            let streamReader = StreamReader(path: Bundle.main.path(forResource: "graphics", ofType: "jsonl")!)!
            for _ in 0..<lineIndex {
                _ = streamReader.nextLine()
            }
            self.hanZiGraphic = try! JSONDecoder().decode(HanZiGraphic.self, from: streamReader.nextLine()!.data(using: .utf8)!)
            streamReader.close()
        } else {
            // Empty HanZi Graphic
            self.hanZiGraphic = HanZiGraphic()
        }
        
        self.strokeIndex = 0
        self.intervalIndex = 0
        self.phases = [CGFloat]()
        self._phases = .init(initialValue: hanZiGraphic.medianPathLengths.map(){ medianPathLength in
            return (medianPathLength + medianPathLength/4)
        })
    }
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.01, paused: paused)) { timeline in
            Canvas() { context, size in
                context.scaleBy(x: 0.25, y: 0.25)
                
                // This draws and fills the paths of the word
                for path in hanZiGraphic.strokePaths {
                    context.fill(
                        Path(path.cgPath).offsetBy(dx: 0, dy: 100).scale(x: 0.5, y: 0.5).shape,
                        with: .color(.gray)
                    )
                }
                
                // Draw the strokes, clip onto path
                for medianPathIndex in 0..<hanZiGraphic.medianPaths.count {
                    let medianPath = hanZiGraphic.medianPaths[medianPathIndex]
                    let medianPathLength = hanZiGraphic.medianPathLengths[medianPathIndex]
                    
                    // Place the stroke in a layer (to clip)
                    context.drawLayer() { layerContext in
                        layerContext.clip(to: Path(hanZiGraphic.strokePaths[medianPathIndex].cgPath).offsetBy(dx: 0, dy: 100))
                        layerContext.stroke(
                            Path(medianPath.cgPath).offsetBy(dx: 0, dy: 100),
                            with: .color(.yellow),
                            style: StrokeStyle(
                                lineWidth: phases[medianPathIndex] <= 0 ? 1024 : 128,
                                lineCap: .round,
                                lineJoin: .round,
                                dash: [medianPathLength+medianPathLength/4, (medianPathLength+medianPathLength/4)+512],
                                dashPhase: phases[medianPathIndex]
                            )
                        )
                    }
                }
            }
            .onAppear() {
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                    if paused {
                        return
                    }
                    phases[strokeIndex] = max(0, phases[strokeIndex] - 12*(log2(speed*CGFloat(intervalIndex)/100+1)+0.05))
                    //phases[strokeIndex] = max(0, phases[strokeIndex] - speed ) // hanZiGraphic.medianPathLengths[strokeIndex]/250
                    intervalIndex += 1
                    
                    if phases[strokeIndex] <= 0 {
                        intervalIndex = 0
                        if strokeIndex >= (phases.count - 1) {
                            paused = true
                        } else {
                            strokeIndex += 1
                        }
                    }
                }
            }
            .onChange(of: reset) { resetState in
                if(resetState){
                    print("reset")
                    reset = false
                    strokeIndex = 0
                    phases = hanZiGraphic.medianPathLengths.map(){ medianPathLength in
                        return (medianPathLength + medianPathLength/4)
                    }
                }
            }
            .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
            .frame(width: 256, height: 256)
        }
    }
}


struct HanZiAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HanZiAnimationView(character: "家", paused: .constant(false))
                .scaledToFit()
            Text("Test animation")
            Spacer()
        }
    }
}

