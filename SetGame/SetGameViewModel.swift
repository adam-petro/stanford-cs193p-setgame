//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Adam Petro on 27/08/2021.
//

import Foundation

class SetGameViewModel: ObservableObject{
    @Published private(set) var model:SetGame
    
    init(){
        let allCards = SetGameViewModel.GeneratePlayingCards()
//        let visibleCards = Array(allCards[0..<12])
//        let deck = Array(allCards[12..<allCards.count])
        self.model = SetGame(deck: allCards)
    }
    
    
    private static func GeneratePlayingCards()->[CardModel]{
        var initialVisibleCards:[CardModel] = []
        for shape in CardFeatures.CardShape.allCases{
            for color in CardFeatures.CardColor.allCases{
                for shading in CardFeatures.CardShapeShading.allCases{
                    for number in 1..<4{
                        initialVisibleCards.append(CardModel(shape: shape, color: color, shading: shading, number: number))
                    }
                }
            }
        }
        initialVisibleCards.shuffle()
        return initialVisibleCards
    }
    
    func makeCardVisible(_ index:Int){
        model.makeCardVisible(index)
    }
    
    func addThreeCards(){
        model.addThreeCards()
    }
    
    func newGame(){
        let allCards = SetGameViewModel.GeneratePlayingCards()
//        let visibleCards = Array(allCards[0..<12])
//        let deck = Array(allCards[12..<allCards.count])
        self.model = SetGame(deck: allCards)
    }
    
    func choose(_ card: CardModel){
        model.choose(card: card, isMatch: isMatch)
    }
    
    private func isMatch(_ cards: [CardModel])->Bool{
        if (cards.count<3){
            return false
        }
        let colors = cards.map({$0.color})
        let shadings = cards.map({$0.shading})
        let shapes = cards.map({$0.shape})
        let numbers = cards.map({$0.number})
        if(identicalOrDistinct(colors)
            && identicalOrDistinct(shadings)
            && identicalOrDistinct(shapes)
            && identicalOrDistinct(numbers)){
            return true
        }
        return false
    }
    private func identicalOrDistinct<Element:Equatable>(_ elements: [Element])->Bool{
        if (elements[0] == elements[1] && elements[1] == elements[2]){
            return true
        }
        if(elements[0] != elements[1] && elements[1] != elements[2] && elements[0] != elements[2]){
            return true
        }
        return false
    }
    
}
