//
//  SwiftUIView.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 04/06/2025.
//
import SwiftUI

struct Card: Identifiable {
    let id = UUID().uuidString
    let cardColor: Color
    let cardBalance: String
}

struct SwiftUIView: View {
    @State var cards: [Card] = [
        Card(cardColor: .blue, cardBalance: "$2,500"),
        Card(cardColor: .brown, cardBalance: "$3,800"),
        Card(cardColor: .green, cardBalance: "$1,200"),
        Card(cardColor: .orange, cardBalance: "$3,800"),
        Card(cardColor: .pink, cardBalance: "$950")
    ]
    
    @State var expandCards: Bool = false
    @Namespace var animation

    var body: some View {
        VStack(spacing: 0) {
            CardContent()
        }
    }

    @ViewBuilder
    func CardContent() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                /// Simply Reverse the Array
                ForEach(cards.reversed()) { card in
                    let index = CGFloat(indexOf(card))
                    let reversedIndex = CGFloat(cards.count - 1) - index

                    let displayingStackIndex = min(index, 4)
                    let displayScale = (displayingStackIndex / CGFloat(cards.count)) * 0.15

                    CardView(card)
                        .frame(height: 210)
                        // Applying Scaling
                        .scaleEffect(1 - displayScale)
                        .offset(y: displayingStackIndex * -15)
                        .offset(y: reversedIndex * -200)
                }
            }
            .padding(.top, expandCards ? 45 : 60)
            .padding(.bottom, CGFloat(cards.count - 1) * -200)
        }
        .scrollDisabled(true)
    }

    /// Card Index
    func indexOf(_ card: Card) -> Int {
        return cards.firstIndex { $0.id == card.id } ?? 0
    }
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader {_ in
            VStack(spacing: 0) {
                Rectangle()
                    .fill(card.cardColor.gradient)
                    .overlay(alignment: .top) {
                        VStack {
                            HStack {
                                Image("Sim")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 55)

                                Spacer(minLength: 0)

                                Image(systemName: "wave.3.right")
                                    .font(.largeTitle.bold())
                            }

                            Text(card.cardBalance)
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(y: 5)
                        }
                        .padding()
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
        .frame(height: 200)
        .padding(.horizontal, 10)
    }
    
    // Retreiving Index
    func getIndex(Card: Card)-> Int {
        return cards.firstIndex { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
    
}

#Preview {
    SwiftUIView()
}
