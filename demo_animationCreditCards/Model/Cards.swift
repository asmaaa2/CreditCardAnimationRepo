//
//  Cards.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 01/06/2025.
//

import SwiftUI

struct Cards: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
}

var cards: [Cards] = [
    Cards(name: "A", cardNumber: "1234 56789", cardImage: "image1"),
    Cards(name: "B", cardNumber: "1234 56789", cardImage: "image2"),
    Cards(name: "C", cardNumber: "1234 56789", cardImage: "image3")
]
