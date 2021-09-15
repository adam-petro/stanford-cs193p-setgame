//
//  SetGame.swift
//  SetGame
//
//  Created by Adam Petro on 26/08/2021.
//

import Foundation

struct SetGame{
    var deck: [CardModel]
    var visibleCards: [CardModel] = []
    var discardedCards: [CardModel] = []
    private(set) var score:Int = 0
    
    mutating func addThreeCards(){
        guard visibleCards.count>=3 else {return}
        let existingSet = visibleCards.filter({$0.isMatched})
        let possibleCards = deck.prefix(GameConsts.cardsToAdd)
        if (existingSet.count == 3){
            //replace
            for index in existingSet.indices{
                if let indexOfNewCard = deck.firstIndex(where: {possibleCards[index].id == $0.id}){
                    if let indexOfOldCard = visibleCards.firstIndex(where: {existingSet[index].id == $0.id}){
                        makeCardDiscarded(indexOfOldCard)//put card to discarded
                        deck[indexOfOldCard].isSelected = false
                        deck[indexOfOldCard].isMatched = false
                        makeCardVisible(indexOfNewCard)
                    }
                }
            }
            return
            
        }
        for possibleCard in possibleCards{
            if let index = deck.firstIndex(where: {$0.id == possibleCard.id}){
                makeCardVisible(index)
            }
        }
    }
    
    mutating func makeCardVisible(_ index: Int){
        visibleCards.append(deck[index])
        deck.remove(at: index)
    }
    
    mutating func makeCardDiscarded(_ index: Int){
        discardedCards.append(visibleCards[index])
        visibleCards.remove(at: index)
    }
    
    mutating func choose(card: CardModel, isMatch: ([CardModel])->Bool){
        if let chosenIndex = visibleCards.firstIndex(where: {$0.id == card.id})
        {
            var currentlySelected = visibleCards.filter({$0.isSelected==true})
            let matching = currentlySelected.filter({$0.isMatched==true})
            let misMatching = currentlySelected.filter({$0.isMisMatched==true})
            
            //If there already exists a set, handle it
            if (matching.count==3){
                addThreeCards()
            }
            
            //If there are 3 cards selected and they do not form a set, handle them
            if (misMatching.count==3){
                for index in visibleCards.indices{
                    if(visibleCards[index].isMisMatched){
                        visibleCards[index].isSelected = false
                        visibleCards[index].isMisMatched = false
                    }
                }
            }
            
            //Select/Unselect clicked card in case it wasn't part of set
            if(visibleCards.count>chosenIndex){
                visibleCards[chosenIndex].isSelected.toggle()
            }
            
            //Check if set or no set exists
            currentlySelected = visibleCards.filter({$0.isSelected == true})
            if (currentlySelected.count==3){
                if (isMatch(currentlySelected)){
                    for index in visibleCards.indices{
                        if(visibleCards[index].isSelected){
                            visibleCards[index].isMatched = true
                        }
                    }
                    score+=1
                }
                else{
                    for index in visibleCards.indices{
                        if(visibleCards[index].isSelected){
                            visibleCards[index].isMisMatched = true
                        }
                    }
                    score-=1
                }
            }
        }
    }
}

struct GameConsts{
    static let initialVisibleCards: Int = 12
    static let cardsToAdd: Int = 3
    static let cardDealTime: Double = 0.5
}

