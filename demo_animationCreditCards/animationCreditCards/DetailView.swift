//
//  DetailView.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 03/06/2025.
//

import SwiftUI

struct DetailView: View{
    var currentCard: Cards
    @Binding var showDetailCard: Bool
    //  matched gemoatry effect
    var animation: Namespace.ID
    
    // Delaying Expenses View
    @State var showExpenseView: Bool = false
    
    var body: some View {
        VStack{
            GeometryReader{proxy in
                
                let height = proxy.size.height + 50
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 20) {
                        // Expenses
                        ForEach(expenses){expense in
                            HStack{
                                Button {
                                    // Closing Expenses View First
                                    withAnimation(.easeInOut) {
                                        showExpenseView = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                        
                                    }
                                    withAnimation(.easeOut(duration: 0.35)){
                                        showDetailCard = false
                                    }
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(.white, in: Circle())
                                }
                            }
                            //Card view
                            CardView()
                                .matchedGeometryEffect(id: currentCard.id, in: animation)
                                .frame(height: 200)
                                .zIndex(10)
                            ExpenseCardView(expense: expense)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(
                    Color.gray
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .ignoresSafeArea()
                )
                .offset(y: showDetailCard ? 0 : height)
            }
            .padding(.top, 150)
            .zIndex(-10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        //        .background(Color(.gray).ignoresSafeArea())
        .onAppear{
            withAnimation(.easeInOut.delay(0.1)){
                showExpenseView = true
            }
        }
    }
    
    @ViewBuilder
    func CardView()-> some View {
        ZStack(alignment: .bottomLeading){
            Image(currentCard.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // Card Details
            VStack(alignment: .leading, spacing: 10) {
                Text(currentCard.name)
                    .fontWeight(.bold)
                
                Text(customisedCardNumber(number: currentCard.cardNumber))
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .padding()
            .padding(.bottom, 10)
            .foregroundStyle(.white)
        }
    }
}

