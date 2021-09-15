//
//  DeckView.swift
//  SetGame
//
//  Created by Adam Petro on 11/09/2021.
//

import SwiftUI

struct DeckView: View {
    var viewModel:SetGameViewModel
    var cards:[CardModel]
    var namespace: Namespace.ID
    init(model: SetGameViewModel, namespace: Namespace.ID){
        self.viewModel = model
        self.cards = viewModel.model.deck
        self.namespace = namespace
    }
    private func zIndex(of card: CardModel)->Double{
        -Double(viewModel.model.deck.firstIndex(where: { $0.id == card.id }) ?? 0)
        
    }
    var body: some View {
        ZStack{
            ForEach(cards.indices,id:\.self){index in
                RoundedRect()
                    .aspectRatio(2/3, contentMode: .fit)
                                .offset(x:index<5 ? CGFloat(index)*3.0: 0.0)
                                .rotationEffect(.degrees(index<5 ? Double(index)*3.0: 0.0))
                                .zIndex(zIndex(of: cards[index]))
                            .matchedGeometryEffect(id: cards[index].id, in: namespace)
            }
        }
    }
    
    func RoundedRect() -> some View{
        ZStack{
        let cardOutline = RoundedRectangle(cornerRadius: CardView.CardConsts.cornerRadius)
            cardOutline.foregroundColor(.white)
            cardOutline.strokeBorder(lineWidth: CardView.CardConsts.borderThickness)
    }
    }
}
