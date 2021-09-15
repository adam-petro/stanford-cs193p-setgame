//
//  CardShapes.swift
//  SetGame
//
//  Created by Adam Petro on 21/08/2021.
//

import Foundation
import SwiftUI



struct CardShapeWrapper: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }

    private let _path: (CGRect) -> Path
}

struct PillShape: Shape{
    
    var width: CGFloat
    var height:CGFloat{
        return width*2.5
    }
    
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: CGPoint(x:rect.midX-width/2,y:rect.midY-height/2))
        
        p.addLine(to:CGPoint(x:rect.midX-width/2,y:rect.midY+height/2))
        
        p.addArc(center: CGPoint(x:rect.midX,y:rect.midY+height/2), radius: width/2, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: true)
        
        p.addLine(to:CGPoint(x:rect.midX+width/2, y: rect.midY))
        
        p.addArc(center: CGPoint(x:rect.midX,y:rect.midY-height/2), radius: width/2, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
        return p
    }
}

struct SquiggleShape:Shape{

    var width: CGFloat
    var height: CGFloat{
        return width*3.5
    }

    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addRect(CGRect(x: rect.midX-width/2, y: rect.midY-height/2, width: width, height: height))
        
        return p
    }
}

struct DiamondShape:Shape{
    
    var width: CGFloat
    var height: CGFloat{
        return width*3.5
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x:rect.midX, y: rect.midY-height/2))
        p.addLine(to: CGPoint(x: rect.midX-width/2, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.midY+height/2))
        p.addLine(to: CGPoint(x: rect.midX+width/2, y: rect.midY))
        p.addLine(to: CGPoint(x:rect.midX, y: rect.midY-height/2))
        
        return p
    }
}
