//
//  EnumAdapters.swift
//  SetGame
//
//  Created by Adam Petro on 26/08/2021.
//

import Foundation
import SwiftUI

func CardShadingAdapter(from enumValue:CardFeatures.CardShapeShading)->Double{
    switch enumValue {
    case .opaque:
        return 1.0
    case .semiOpaque:
        return 0.2
    case .transparent:
        return 0.0
    }
}

func CardShapeAdapter(from enumValue:CardFeatures.CardShape, width:CGFloat)->some Shape{
    switch enumValue{
    case .diamond:
        return CardShapeWrapper(DiamondShape(width: width))
    case .pill:
        return CardShapeWrapper(PillShape(width: width))
    case .squiggle:
        return CardShapeWrapper(SquiggleShape(width: width))
    }
}

func CardColorAdapter(from enumValue: CardFeatures.CardColor)->Color{
    switch enumValue {
    case .green:
        return Color.green
    case .purple:
        return Color.purple
    case .red:
        return Color.red
    }
}
