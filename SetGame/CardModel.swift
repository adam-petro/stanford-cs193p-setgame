//
//  CardModel.swift
//  SetGame
//
//  Created by Adam Petro on 26/08/2021.
//

import Foundation
struct CardModel: Identifiable{
    
    
    // 4 Attributes of Set Game Card
    var shape: CardFeatures.CardShape
    var number: Int
    var color: CardFeatures.CardColor
    var shading: CardFeatures.CardShapeShading
    var isSelected: Bool = false
    var isMatched: Bool = false
    var isMisMatched: Bool = false
    var id: UUID = UUID()
    
    init(shape: CardFeatures.CardShape, color: CardFeatures.CardColor, shading: CardFeatures.CardShapeShading, number: Int) {
        self.shape = shape
        self.color = color
        self.shading = shading
        guard number<4 else{
            fatalError("Attempted to set number of symbols greater than 3.")
        }
        self.number = number
    }
}


struct CardFeatures{
    enum CardShape: CaseIterable{
        case diamond
        case squiggle
        case pill
    }
    
    enum CardColor: CaseIterable{
        case red
        case green
        case purple
    }
    
    enum CardShapeShading:CaseIterable{
        case opaque
        case semiOpaque
        case transparent
    }
}
