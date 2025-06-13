//
//  Home.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 01/06/2025.
//

import SwiftUI


struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController2()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Home: View {
    // MARK: Animation properties
    @State var expandCards: Bool = false
    
    // MARK: Deatils View Properties
    @State var currentCard: Cards?
    @State var showDeatilsCard: Bool = false
    @State private var isNavigatingToUIKit = false
    
    @Namespace var animation
    
    var cards: [Cards]
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                headerView()
                cardsScrollView()
                Button {
                    print("click on Orange BTN")
                    isNavigatingToUIKit = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.red, in: Circle())
                }
                .padding(.vertical, 5)
                NavigationLink(
                    destination: UIKitViewControllerWrapper(),
                    //                    .navigationBarBackButtonHidden(true),
                    isActive: $isNavigatingToUIKit,
                    label: {
                        EmptyView()
                    }
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if let currentCard = currentCard, showDeatilsCard {
                    DetailView(currentCard: currentCard, showDetailCard: $showDeatilsCard, animation: animation)
                }
            }
        }
    }
    
    
    @ViewBuilder
    func headerView() -> some View {
        VStack{
            Text("Apply for a credit card now")
                .font(.title)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Unlock a world of benefits, rewards & much more")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func cardsScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 0){
                ForEach(cards) { card in
                    
                    let index = CGFloat(indexOf(card))
                    let reversedIndex = CGFloat(cards.count - 1) - index
                    
                    let displayingStackIndex = min(index, 5)
                    let displayScale = (displayingStackIndex / CGFloat(cards.count)) * 0.15
                    
                    CardView(card: card)
                        .scaleEffect()
                        .offset(y: displayingStackIndex * -2)
                        .offset(y: reversedIndex - 15)
                        .matchedGeometryEffect(id: card.id, in: animation)
                        .onTapGesture {
                            print("click on the card to pass Data for persented Screen")
                            withAnimation(.easeInOut(duration: 0.35)) {
                                currentCard = card
                                showDeatilsCard = true
                            }
                        }
                }
                Button {
                    withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                        expandCards = false
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.blue, in: Circle())
                }
                .rotationEffect(.init(degrees: expandCards ? 45 : 0))
                .opacity(expandCards ? 1 : 0)
                .padding(.top, 30)
            }
            .overlay {
                // to avoid Scrolling
                Rectangle()
                    .fill(.black.opacity(expandCards ? 0 : 0.01))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            expandCards = true
                        }
                    }
                
            }
            .padding(.top, expandCards ? 45 : 0)
            .padding(.bottom, expandCards ? 0 : CGFloat(cards.count - 1) * -200)
            Button {
                print("click on Orange BTN")
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.orange, in: Circle())
            }
            .opacity(expandCards ? 0 : 1)
            .padding(.top, 55)
            if !expandCards {
                VStack(alignment: .center, spacing: 0){
                    HStack {
                        Image(systemName: "plus")
                        Text("Enjoy up to 57 days grace period")
                    }
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("install payment up to 6–24 months at a large network of merchants.")
                    }
                    HStack {
                        Image(systemName: "plus")
                        Text("Earn points with every transaction.")
                    }
                }
            }
        }
        .scrollDisabled(expandCards ? false : true)
        .coordinateSpace(name: "SCROLL")
        .offset(y: expandCards ? 0 : 30) // to start expand from same point in the screen
    }
    
    
    @ViewBuilder
    func CardView(card: Cards) -> some View {
        GeometryReader{proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            let offset = CGFloat(getIndex(Card: card) * (expandCards ? 10 : 25))
            
            VStack {
                ZStack(alignment: .bottomLeading){
                    Image(currentCard?.cardImage ?? "image1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    if expandCards{
                        VStack(alignment: .leading, spacing: 10) {
                            Text(currentCard?.name ?? "ASMA")
                                .fontWeight(.bold)
                            
                            Text(customisedCardNumber(number: currentCard?.cardNumber ?? "123456789"))
                                .font(.callout)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .frame(width: rect.width, alignment: .leading)
                        .padding(.bottom, 10)
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 0.50)
            )
            // Making it as a Stack
            .offset(y: expandCards ? offset : -rect.minY  + offset)
        }
        .frame(height: 200)
    }
    
    // Retreiving Index
    func getIndex(Card: Cards)-> Int {
        return cards.firstIndex { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
    
    /// Card Index
    func indexOf(_ card: Cards) -> Int {
        return cards.firstIndex { $0.id == card.id } ?? 0
    }
    
}



// MARK: Present Screen from Core
private func presentUIKitView() {
    let viewController = ViewController()
    
    if let root = UIApplication.shared.connectedScenes
        .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
        .first?.rootViewController {
        root.present(viewController, animated: true)
    }
}


// MARK: Hiding all Number except last four
func customisedCardNumber(number: String)-> String {
    var newValue: String = ""
    let maxCount = number.count - 4
    number.enumerated().forEach{value in
        if value.offset >= maxCount {
            let string = String(value.element)
            newValue.append(contentsOf: string)
            
        } else {
            let string = String(value.element)
            if string == " " {
                newValue.append(contentsOf: " ")
            }
            else {
                newValue.append(contentsOf: "*")
            }
        }
    }
    return newValue
}

#Preview {
    Home(cards: [
        Cards(name: "A", cardNumber: "1234 56789", cardImage: "image1"),
        Cards(name: "B", cardNumber: "1234 56789", cardImage: "image2"),
        Cards(name: "C", cardNumber: "1234 56789", cardImage: "image3"),
        Cards(name: "A", cardNumber: "1234 56789", cardImage: "image1"),
        Cards(name: "B", cardNumber: "1234 56789", cardImage: "image2"),
        Cards(name: "C", cardNumber: "1234 56789", cardImage: "image3")
    ])
}
