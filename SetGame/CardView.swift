//
//  CardView.swift
//  SetGame
//
//  Created by Adam Petro on 21/08/2021.
//

import SwiftUI

struct CardView: View {
    var card: CardModel
    var opacity:Double{
        CardShadingAdapter(from: card.shading)
    }
    func shape (_ width: CGFloat) -> some Shape{
        CardShapeAdapter(from: card.shape, width: width)
    }
    var color: Color{
        CardColorAdapter(from: card.color)
    }
    var singleShapeSize:CGFloat{
        sqrt(CGFloat(card.number)*CardConsts.contentSizeMultiplyingModifier)+CardConsts.contentSizeConstantModifier
    }
    
    

    
    var body: some View {
        ZStack{
            let cardOutline =
                RoundedRectangle(cornerRadius: CardConsts.cornerRadius)
            cardOutline.aspectRatio(2/3, contentMode: .fit)
            cardOutline.foregroundColor(CardConsts.fillColor).shadow(color: CardConsts.shadowColor, radius: 1, x: 4, y:5)
            cardOutline.strokeBorder(lineWidth: CardConsts.borderThickness, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).foregroundColor(card.isMatched ?  CardConsts.matchedBorderColor : card.isMisMatched ? CardConsts.misMatchedBorderColor : card.isSelected ? CardConsts.selectedBorderColor : CardConsts.borderColor)
            GeometryReader{ geometry in
                HStack{
                    Spacer()
                    ForEach(0..<card.number, id:\.self){iterator in
                        ZStack{
                            let shape = self.shape(CGFloat(geometry.size.width*singleShapeSize))
                            shape.fill(color).opacity(opacity)
                            shape.stroke(color)
                        }
                    }
                    Spacer()
                }
            }
        }
        .scaleEffect(x: card.isSelected ? 1.05 : 1.0, y:card.isSelected ? 1.05 : 1.0)
        .rotationEffect(Angle(degrees: card.isMisMatched ? 3 : 0))
        .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))

    }
    struct CardConsts{
        static let cornerRadius:CGFloat = 15.0
        static let fillColor: Color = .white
        static let borderColor: Color = .black
        static let matchedBorderColor: Color = .green
        static let selectedBorderColor: Color = .blue
        static let misMatchedBorderColor: Color = .red
        static let shadowColor: Color = .gray
        static let borderThickness: CGFloat = 3
        static let contentSizeMultiplyingModifier: CGFloat = 0.00005
        static let contentSizeConstantModifier: CGFloat = 0.21
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var cardModel = CardModel(shape: .pill, color: .purple, shading: .opaque, number: 1)
//    static var cardModel2 = CardModel(shape: .pill, color: .purple, shading: .opaque, number: 2)
//    static var cardModel3 = CardModel(shape: .pill, color: .purple, shading: .opaque, number: 3)
//    static var previews: some View {
//        CardView(card: cardModel).padding()
//        CardView(card: cardModel2).padding()
//        CardView(card: cardModel3).padding()
//    }
//
//}
