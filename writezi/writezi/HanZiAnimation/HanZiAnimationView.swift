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
    let speed: CGFloat
    
    // HanZiGraphic
    @State var hanZiGraphic: HanZiGraphic
    
    // Animation related
    @State var strokeIndex: Int
    @State var phases: [CGFloat]
    
    // Controlling from parent
    @Binding var paused: Bool
    
    init(character: Character, speed: CGFloat = 200.0, paused: Binding<Bool> = .constant(false)) {
        self.character = character
        self.speed = speed
        self._paused = paused
        
        // Word to HanZiGraphic logic
        let content = #"{"character":"琛","strokes":["M 247 685 Q 364 718 369 721 Q 376 728 372 737 Q 365 747 335 753 Q 310 757 239 730 Q 188 714 131 705 Q 97 696 122 682 Q 161 664 209 675 L 247 685 Z","M 275 481 Q 294 488 316 494 Q 341 501 345 506 Q 352 515 348 522 Q 341 532 313 536 Q 294 539 276 532 L 228 511 Q 134 487 121 483 Q 88 474 114 461 Q 153 442 203 460 Q 213 464 228 467 L 275 481 Z","M 270 319 Q 271 406 275 481 L 276 532 Q 279 656 280 657 Q 279 660 278 660 Q 262 676 247 685 C 222 702 199 703 209 675 Q 224 639 228 557 Q 228 539 228 511 L 228 467 Q 228 401 228 303 C 228 273 270 289 270 319 Z","M 228 303 Q 173 284 115 261 Q 99 254 70 253 Q 57 250 55 240 Q 54 225 65 218 Q 90 205 125 187 Q 137 186 148 195 Q 182 228 326 308 Q 347 321 361 334 Q 374 344 374 353 Q 365 359 270 319 L 228 303 Z","M 452 743 Q 439 770 423 779 Q 420 783 414 780 Q 410 776 408 766 Q 412 736 383 672 Q 373 656 373 638 Q 376 619 385 606 Q 392 594 398 602 Q 410 605 426 650 Q 438 687 454 716 C 460 727 460 727 452 743 Z","M 454 716 Q 473 706 524 719 Q 602 749 736 762 Q 745 763 750 762 Q 763 752 762 746 Q 762 745 741 685 Q 735 672 741 669 Q 748 665 762 676 Q 808 707 846 719 Q 877 729 877 736 Q 876 745 811 790 Q 787 806 676 781 Q 669 781 521 754 Q 487 747 452 743 C 422 739 425 724 454 716 Z","M 497 657 Q 507 627 429 516 Q 422 509 420 506 Q 419 499 427 500 Q 461 509 532 599 Q 542 614 550 621 Q 557 628 554 636 Q 551 645 533 660 Q 517 673 504 673 Q 492 672 497 657 Z","M 662 636 Q 693 606 724 571 Q 734 559 747 559 Q 756 558 761 569 Q 765 581 761 605 Q 758 627 728 647 Q 658 683 644 679 Q 640 676 640 665 Q 641 655 662 636 Z","M 623 422 Q 662 432 798 448 Q 808 447 817 459 Q 818 469 796 480 Q 769 501 687 477 Q 656 470 625 462 L 572 450 Q 529 444 490 438 Q 445 434 396 427 Q 369 424 390 407 Q 420 382 448 389 Q 493 399 549 409 L 623 422 Z","M 622 415 Q 622 419 623 422 L 625 462 Q 626 493 631 511 Q 634 524 626 530 Q 604 551 583 560 Q 571 564 562 557 Q 556 553 563 543 Q 573 525 575 454 L 573 359 Q 557 133 549 108 Q 537 75 571 20 L 573 17 Q 583 -2 592 -7 Q 604 -8 609 5 Q 622 38 619 69 Q 618 231 621 365 Q 621 372 621 378 L 622 415 Z","M 549 409 Q 480 288 299 158 Q 287 148 296 145 Q 303 141 316 145 Q 436 188 569 355 Q 570 358 573 359 C 624 416 567 440 549 409 Z","M 621 378 Q 694 275 788 166 Q 807 147 837 149 Q 937 155 970 162 Q 979 163 980 169 Q 981 173 967 181 Q 813 241 757 291 Q 693 345 622 415 C 601 436 604 402 621 378 Z"],"medians":[[[124,694],[184,692],[315,729],[364,729]],[[115,473],[150,470],[240,492],[297,513],[337,516]],[[216,672],[242,656],[249,645],[253,598],[250,343],[233,312]],[[72,236],[128,227],[371,349]],[[417,770],[430,741],[428,721],[397,642],[395,614]],[[460,737],[470,728],[494,730],[564,750],[713,776],[766,776],[793,761],[803,746],[746,675]],[[504,663],[517,651],[523,635],[516,618],[466,544],[428,508]],[[647,670],[719,619],[748,573]],[[391,418],[420,410],[450,411],[704,460],[756,467],[807,461]],[[571,551],[601,513],[582,90],[595,5]],[[569,407],[534,345],[462,266],[371,190],[302,151]],[[627,409],[636,380],[697,312],[764,244],[821,197],[973,168]]]}"#
        let data = content.data(using: .utf8)!
        hanZiGraphic = try! JSONDecoder().decode(HanZiGraphic.self, from: data)
        
        self.strokeIndex = 0
        self.phases = [CGFloat]()
        self._phases = .init(initialValue: hanZiGraphic.medianPathLengths.map(){ medianPathLength in
            return (medianPathLength + medianPathLength/4)
        })
        print(phases)
    }
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.001, paused: paused)) { timeline in
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
                var intervalIndex = 0
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                    if paused {
                        return
                    }
                        
                    phases[strokeIndex] = max(0, phases[strokeIndex] - 12*(log2(speed*CGFloat(intervalIndex)/100+1)+0.05))
                    //phases[strokeIndex] = max(0, phases[strokeIndex] - speed ) // hanZiGraphic.medianPathLengths[strokeIndex]/250
                    intervalIndex += 1

                    
                    if phases[strokeIndex] <= 0 {
                        if strokeIndex >= (phases.count - 1) {
                            timer.invalidate()
                        } else {
                            strokeIndex += 1
                            intervalIndex = 0
                        }
                    }
                }
            }
            .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
            .border(Color.blue)
            .frame(width: 256, height: 256)
        }
    }
}


struct HanZiAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HanZiAnimationView(character: "家", paused: .constant(false))
                .scaledToFit()
            Text("Text")
            Spacer()
        }
    }
}

