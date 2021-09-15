//
//  ContentView.swift
//  SetGame
//
//  Created by Adam Petro on 21/08/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetGameViewModel
    @Namespace var dealingNamespace

    
    
    var body: some View {
        VStack(){
            VStack(alignment: .leading){
                Button("New Game"){
                    viewModel.newGame()
                }
                Text("Score: \(viewModel.model.score)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            AspectVGrid(items: viewModel.model.visibleCards, aspectRatio: 2/3, maxColumn:5, content: { card in
                CardView(card: card)
                    .padding(4)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .onTapGesture {
                        withAnimation{
                            viewModel.choose(card)
                        }
                    }
            })
            .padding(.horizontal, 5)
            HStack{
                DiscardedPileView(model: viewModel, namespace:dealingNamespace)
                Spacer()
                if(viewModel.model.deck.count>3){                DeckView(model: viewModel, namespace:dealingNamespace)            .onTapGesture {
                    withAnimation {
                        viewModel.addThreeCards()
                    }
                }
                .onAppear{
                    for index in 0..<GameConsts.initialVisibleCards{
                        withAnimation(addTakeAnimation(for: index)){
                            viewModel.makeCardVisible(index)                        }
                    }
                }
                }
            }
            .padding(20.0)
            .frame(height: 150.0)
        }
        .padding(.horizontal)
    }
    
    private func addTakeAnimation(for index: Int) -> Animation {
        var delay = 0.0
        delay = Double(index) * (GameConsts.cardDealTime / Double(GameConsts.initialVisibleCards))
        return Animation.easeInOut(duration: GameConsts.cardDealTime).delay(delay)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetGameViewModel()
        ContentView(viewModel: viewModel)
    }
}
