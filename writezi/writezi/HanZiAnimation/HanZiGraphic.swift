//
//  HanZiGraphic.swift
//  writezi
//
//  Created by James Ryan Chen on 20/11/21.
//

import Foundation
import SwiftUI

struct HanZiGraphic: Codable {
    let character: String
    let strokes: [String]
    let medians: [[[Int]]]
    let strokePaths: [UIBezierPath]
    let medianPaths: [UIBezierPath]
    let medianPathLengths: [CGFloat]
    
    enum CodingKeys: String, CodingKey {
        case character
        case strokes
        case medians
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        character = try container.decode(String.self, forKey: .character)
        strokes = try container.decode([String].self, forKey: .strokes)
        medians = try container.decode([[[Int]]].self, forKey: .medians)
        
        strokePaths = strokes.map() { stroke in
            return stroke.toUIBezierPathFromSVGDataPath()
        }
        
        medianPaths = medians.map() { median in
            let path = UIBezierPath()
            path.move(to: CGPoint(x: median[0][0], y: median[0][1]))


            median.dropFirst().forEach() { coords in
                path.addLine(to: CGPoint(x: coords[0], y: coords[1]))
            }
            return path
        }
        
        medianPathLengths = medianPaths.map() { medianPath in
            return medianPath.mx_length
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(character, forKey: .character)
        try container.encode(strokes, forKey: .strokes)
        try container.encode(medians, forKey: .medians)
    }
    
}

// String extension for added svg support
extension String {
    // Convert String representations of SVG Data Paths to Swift UIBezierPath
    // Note: Does not cover entire spec, just what is needed to translate makemeahanzi
    func toUIBezierPathFromSVGDataPath() -> UIBezierPath {
        let words = self.components(separatedBy: " ")

        // Separates sets of words beginning with a letter into separate commands (As per SVG Specs... somewhere)
        var cmds: [[String]] = []
        words.forEach() { word in
            // If we start with an alphabetical letter, there is a command
            if word.range(of: "^[.a-zA-Z]$", options: .regularExpression) != nil {
                cmds.append([word])
            } else {
                cmds[cmds.count-1].append(word)
            }
        }

        let path = UIBezierPath()
        cmds.forEach() { cmd in
            switch cmd[0]{
            case "M":
                path.move(to: CGPoint(x: Int(cmd[1])!, y: Int(cmd[2])!))
            case "Q":
                path.addCurve(to: CGPoint(x: Int(cmd[3])!, y: Int(cmd[4])!), controlPoint1: CGPoint(x: Int(cmd[1])!, y: Int(cmd[2])!), controlPoint2: CGPoint(x: Int(cmd[1])!, y: Int(cmd[2])!))
            case "L":
                path.addLine(to: CGPoint(x: Int(cmd[1])!, y: Int(cmd[2])!))
            case "C":
                path.addCurve(to: CGPoint(x: Int(cmd[5])!, y: Int(cmd[6])!), controlPoint1: CGPoint(x: Int(cmd[1])!, y: Int(cmd[2])!), controlPoint2: CGPoint(x: Int(cmd[3])!, y: Int(cmd[4])!))
            case "Z":
                path.close()
            default:
                print("Unexpected character \(cmd[0]): \(cmd.joined(separator: " "))")
            }
        }

        return path
    }
}
